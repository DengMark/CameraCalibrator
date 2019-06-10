function [theta,phi]=backproject_dh(m,p,thetamax)
% [theta,phi]=backproject(m,p,thetamax)
%
% BACKPROJECT gives the directions of incoming rays corresponding
% to given image points
%
% input:
%   m = [u v], M*2-matrix, the image coordinates in pixels
%   p = 6, 9 or 23 vector, the internal camera parameters
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


mu=p(3); mv=p(4); u0=p(5); v0=p(6);
tol=10^(-10);

if nargin<3 | isempty(thetamax)
  [thetafirstmax, thetamax]=examineradialprojection_dh(p);
end

if length(p)<7
  [theta,phi]=backprojectgeneric_dh(m,p,thetamax);
elseif length(p)<10
  k1=p(1); k2=p(2); k3=p(7); k4=p(8); k5=p(9);
  x=1/mu*(m(:,1)-u0);
  y=1/mv*(m(:,2)-v0);

  [theta,phi]=backprojectsymmetric_dh(x,y,[k1 k2 k3 k4 k5],thetamax);

else  
  k1=p(1); k2=p(2); k3=p(7); k4=p(8); k5=p(9);
  dp=p(10:end);
  
  x=1/mu*(m(:,1)-u0);
  y=1/mv*(m(:,2)-v0);
  
  if 1
    [xc,yc]=invasymmetriclinear_dh(x,y,[k1 k2 k3 k4 k5],dp,thetamax);
  %else  % did not work very well
  %  [xc,yc]=distortasymmetric(x,y,[k1 k2 k3 k4 k5],idp,thetamax);
  end  

  [theta,phi]=backprojectsymmetric_dh(xc,yc,[k1 k2 k3 k4 k5],thetamax);  
end

theta=theta(:);
phi=phi(:);
