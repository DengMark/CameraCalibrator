function [theta,phi]=backprojectgeneric_dh(m,p,thetamax)
% [theta,phi]=backprojectgeneric(m,p,thetamax)
%
% BACKPROJECTGENERIC back projects the given image points assuming
% the basic generic camera model
%
% input:
%   m = [u v], M*2-matrix, the image coordinates in pixels
%   p = 6-vector, the internal camera parameters
%   thetamax = maximum value of theta angle
%
% output:
%   theta = M-vector, theta angles of incoming rays
%   phi = M-vector, phi angles of incoming rays
%

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

n=size(m,1);
k1=p(1); k2=p(2); mu=p(3); mv=p(4); u0=p(5); v0=p(6);

x=1/mu*(m(:,1)-u0);
y=1/mv*(m(:,2)-v0);

[r,phi]=xy2rphi_dh(x,y);
 
% roots for a third order polynomial
a3=k2*ones(1,n);
a2=zeros(1,n);
a1=k1*ones(1,n);
a0=-r';
tol=10^(-15);

tmpvar=0;
if abs(k2)<tol % & abs(k1)<tol %only first order
  if abs(k1)<tol
    error('In backprojectgeneric: Model nearly zero everywhere');
  else
    thetam=-a0./a1;
    tmpvar=1;
  end
else    %general case
  thetam=poly3roots_dh(a3,a2,a1,a0);
end


% choose the right root from three possible
ind=( abs(imag(thetam))<tol & thetam>=0 & thetam<thetamax );
if tmpvar
  check=ind;
  theta=thetam;
else
  check=sum(ind);
  theta=sum(ind.*thetam);
  failind=find(check~=1);
  for i=1:length(failind)
    col=failind(i);
    posreal=find(abs(imag(thetam(:,col)))<tol & thetam(:,col)>=0);
    v=thetam(posreal,col);
    if isempty(v)
      theta(col)=thetamax;
      disp('In backprojectgeneric: No proper theta, check initialization');    
    else
      theta(col)=min(v);
    end
  end
end
theta=real(theta);
if length(find(check~=1))~=0
  disp('In backprojectgeneric: Something may be wrong, check initialization if the calibration is not succesfull');
end

theta=theta(:); 
phi=phi(:);
