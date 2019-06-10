function [xc,yc]=invasymmetriclinear_dh(x,y,ks,dp,thetamax)
% [xc,yc]=invasymmetriclinear(x,y,ks,dp,thetamax)
%
% INVASYMMETRICLINEAR corrects the asymmetrically distorted image
% points, uses linear approximation to invert the forward model,
% points must be given in normalised image coordinates
%
% input:
%   x = M*1-vector for the distorted x-coordinates
%   y = M*1-vector for the distorted y-coordinates
%   ks = [k1 k2 k3 k4 k5], the coefficients of the radially
%        symmetric part
%   dp = [i1 i2 i3 j1 j2 j3 l1 l2 l3 l4 m1 m2 m3 m4], the
%        coefficients of the asymmetric part
%   thetamax = maximum value of theta angle
%
% output:
%   xc = M*1-vector for the undistorted x-coordinates   
%   yc = M*1-vector for the undistorted y-coodinates
%

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

M=size(x,1);

[thetas,phis]=backprojectsymmetric_dh(x,y,ks,thetamax);

k1=ks(1); k2=ks(2); k3=ks(3); k4=ks(4); k5=ks(5);

i1=dp(1); i2=dp(2); i3=dp(3);
j1=dp(4); j2=dp(5); j3=dp(6);

l1=dp(7); l2=dp(8); l3=dp(9); l4=dp(10);
m1=dp(11); m2=dp(12); m3=dp(13); m4=dp(14);

if 0
k1=p(1); k2=p(2); mu=p(3); mv=p(4); u0=p(5); v0=p(6);
k3=p(7); k4=p(8); k5=p(9);
i1=p(10); i2=p(11); i3=p(12);
j1=p(13); j2=p(14); j3=p(15);
l1=p(16); l2=p(17); l3=p(18); l4=p(19);
m1=p(20); m2=p(21); m3=p(22); m4=p(23);
end

for i=1:M
  t=thetas(i); phi=phis(i);
  cosp=cos(phi); sinp=sin(phi); cos2p=cos(2*phi); sin2p=sin(2*phi);
  
  tp2=t*t; tp3=t*tp2; tp4=t*tp3; tp5=t*tp4; tp6=t*tp5;
  tp7=t*tp6; tp8=t*tp7; tp9=t*tp8;
  
  kt=k1*t+k2*tp3+k3*tp5+k4*tp7+k5*tp9;
  dktdt=k1+3*k2*tp2+5*k3*tp4+7*k4*tp6+9*k5*tp8;
  
  jt=j1*t+j2*tp3+j3*tp5;
  djtdt=j1+3*j2*tp2+5*j3*tp4;
  
  it=i1*t+i2*tp3+i3*tp5;
  ditdt=i1+3*i2*tp2+5*i3*tp4;
  
  mp=m1*cosp+m2*sinp+m3*cos2p+m4*sin2p;
  dmpdp=-m1*sinp+m2*cosp-2*m3*sin2p+2*m4*cos2p;
  
  lp=l1*cosp+l2*sinp+l3*cos2p+l4*sin2p;
  dlpdp=-l1*sinp+l2*cosp-2*l3*sin2p+2*l4*cos2p;
  
  dF=inv([dktdt*cosp -kt*sinp; dktdt*sinp kt*cosp]);
  
  J=[djtdt*mp*cosp-ditdt*lp*sinp jt*(dmpdp*cosp-mp*sinp)-it*(dlpdp*sinp+lp*cosp);...
     djtdt*mp*sinp+ditdt*lp*cosp jt*(dmpdp*sinp+mp*cosp)+it*(dlpdp*cosp-lp*sinp)]...
    *dF;
  
  h=-pinv(eye(2)+J)*[jt*mp*cosp-it*lp*sinp; jt*mp*sinp+it*lp*cosp];
  xc(i)=x(i)+h(1);
  yc(i)=y(i)+h(2);
end

xc=xc(:);
yc=yc(:);
