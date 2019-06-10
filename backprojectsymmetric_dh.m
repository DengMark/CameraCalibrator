function [theta,phi]=backprojectsymmetric_dh(x,y,ks,thetamax)
% [theta,phi]=backprojectsymmetric(m,p,thetamax)
%
% BACKPROJECTSYMMETRIC back projects the given image points assuming
% the 9th order radially symmetric camera model
%
% input:
%   m = [u v], M*2-matrix, the image coordinates in pixels
%   p = 9-vector, the internal camera parameters
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


k1=ks(1); k2=ks(2); k3=ks(3); k4=ks(4); k5=ks(5);

M=size(x,1);
[r,phi]=xy2rphi_dh(x,y);

theta=zeros(M,1);
tol=10^(-12);
for i=1:M
  c=[k5 0 k4 0 k3 0 k2 0 k1 -r(i)];
  thetam=roots(c);
  ind=( abs(imag(thetam))<tol & thetam>=0 & thetam<thetamax ); %查找（0，thetamax）之间的实根
  if sum(ind)>1 %有多个满足条件的实根theta
    disp('In backprojectsymmetric: Warning, theta not unique, the radial projection may not be accurate up to the nominal theta_max. Check.');
    theta(i)=min(real(thetam(find(ind))));
  elseif sum(ind)<1 %没有实根
    disp('In backprojectsymmetric: Warning, no proper theta');
    theta(i)=thetamax;
  else  %只有一个满足条件的实根
    theta(i)=real(thetam(find(ind)));
  end
end

theta=theta(:);
phi=phi(:);

