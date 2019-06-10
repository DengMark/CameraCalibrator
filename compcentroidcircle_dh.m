function [cmx,cmy]=compcentroidcircle_dh(a,b,w,R,t,X0v,lp)
% [cmx,cmy]=compcentroidcircle(A,B,W,R,t,X0v,lp)
%
% COMPCENTROIDCIRCLE computes the centroid of the projected circle
% in normalised image coordinates by numerical integration
%
% input:
%   A = values of alpha angle at grid points
%   B = values of radius at grid points 
%   W = weights at grid points
%   R = rotation between the plane and camera
%   t = translation between the plane and camera
%   X0v = [X0 Y0], circle center in the plane
%   lp = [k1 k2 k3 k4 k5 i1 i2 i3 j1 j2 j3 l1 l2 l3 l4 m1 m2 m3 m4],
%        parameters that define the projection to normalised coordinates
%  
% output:
%   cmx = x-coordinate of the centroid
%   cmy = y-coordinate of the centroid
%
% See also MAKENINTMATS

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

% note that parameters are defined as follows:
% r = k1*theta+k2*theta.^3+k3*theta.^5+k4*theta.^7+k5*theta.^9;
% dt=(i1*theta+i2*theta.^3+i3*theta.^5).*...
%    (l1*cosphi+l2*sinphi+l3*cos2phi+l4*sin2phi);
% dr=(j1*theta+j2*theta.^3+j3*theta.^5).*...
%    (m1*cosphi+m2*sinphi+m3*cos2phi+m4*sin2phi);

X0=X0v(1); Y0=X0v(2);
f=lp(1); k1=lp(2); k2=lp(3); k3=lp(4); k4=lp(5);
i=lp(6:8);
i1=lp(6); i2=lp(7); i3=lp(8);
j=lp(9:11);
j1=lp(9); j2=lp(10); j3=lp(11);
l=lp(12:15);
l1=lp(12); l2=lp(13); l3=lp(14); l4=lp(15);
m=lp(16:19);
m1=lp(16); m2=lp(17); m3=lp(18); m4=lp(19);

r11=R(1,1); r12=R(1,2); %r13=R(1,3);
r21=R(2,1); r22=R(2,2); %r23=R(2,3);
r31=R(3,1); r32=R(3,2); %r33=R(3,3);

t1=t(1); t2=t(2); t3=t(3);

cosa=cos(a); sina=sin(a);
bcosa=b.*cosa; bsina=b.*sina;
X0bcosa=X0+bcosa; Y0bsina=Y0+bsina;

A1=r11.*X0bcosa+r12.*Y0bsina+t1;
A2=r21.*X0bcosa+r22.*Y0bsina+t2;
A3=r31.*X0bcosa+r32.*Y0bsina+t3;

B1=r12.*bcosa-r11.*bsina;
B2=r22.*bcosa-r21.*bsina;
B3=r32.*bcosa-r31.*bsina;

C1=r11.*cosa+r12.*sina;
C2=r21.*cosa+r22.*sina;
C3=r31.*cosa+r32.*sina;

D1=2*(A1.*B1+A2.*B2);
D2=2*(A1.*C1+A2.*C2);

F1=A1.^2+A2.^2;
F1p2=F1.^2;
F2=sqrt(F1);
F3=F1+A3.^2;
F4=sqrt(F3);
F6=F3.*F4;

E1=acos(A3./F4);
E1p2=E1.^2;E1p3=E1.^3;
E1p4=E1p2.^2;E1p5=E1.^5;

AAF=A1.*A2./F1;

if [l(:);m(:);i(:);j(:)]==0
  fullmodel=0;
else
  fullmodel=1;
  lAlA=l1.*A1+l2.*A2;
  G1=lAlA./F2+l3*(2*A1.^2./F1-1)+2*l4*AAF;
  mAmA=m1.*A1+m2.*A2;
  G3=mAmA./F2+m3*(2*A1.^2./F1-1)+2*m4*AAF;
  G2=i1*E1+i2*E1p3+i3*E1p5;
  G4=j1*E1+j2*E1p3+j3*E1p5;
end

H1=f+3*k1*E1p2+5*k2*E1p4+7*k3*E1p3.^2+9*k4*E1p4.^2;
H2=j1+3*j2*E1p2+5*j3*E1p4;
H3=i1+3*i2*E1p2+5*i3*E1p4;

E0=f*E1+k1*E1p3+k2*E1p5+k3*E1p3.*E1p4+k4*E1p4.*E1p5;
if ~fullmodel
  E2=E0;
else  
  E2=E0+G3.*G4;
end
E3=1-(A3.^2)./F3;
E3sqrt=sqrt(E3);
E4=B3./F4-A3.*(D1+2*A3.*B3)./(2*F6);
E5=C3./F4-A3.*(D2+2*A3.*C3)./(2*F6);
E6=2*A1./F1.*(2*B1-A1.*D1./F1);
E7=2*A1./F1.*(2*C1-A1.*D2./F1);

D1p2F1=D1./(2*F1);
D2p2F1=D2./(2*F1);

V1=A1.*B2+A2.*B1;
V2=A1.*C2+A2.*C1;
U2=E2./(2*F1);

if ~fullmodel
  K1=-E4.*H1./E3sqrt;
  K2=-E5.*H1./E3sqrt;
  
  L1=A1.*K1-U2.*A1.*D1+E2.*B1;
  L2=A2.*K2-U2.*A2.*D2+E2.*C2;
  L3=A2.*K1-U2.*A2.*D1+E2.*B2;
  L4=A1.*K2-U2.*A1.*D2+E2.*C1;
  
  x=A1.*E0./F2;
  y=A2.*E0./F2;
else
  T1=mAmA;
  T2=m1*B1+m2*B2;
  T3=m1*C1+m2*C2;
  T4=lAlA;
  T5=l1*B1+l2*B2;
  T6=l1*C1+l2*C2;
  
  U1=AAF;
  U3=G1.*G2;

  tmp=(-G3.*H2-H1)./E3sqrt;
  K1=E4.*tmp+G4.*(T2./F2+2*m4*(V1-U1.*D1)./F1-T1.*D1p2F1./F2+m3*E6);
  K2=E5.*tmp+G4.*(T3./F2+2*m4*(V2-U1.*D2)./F1-T1.*D2p2F1./F2+m3*E7);
  S1=G2.*(2*l4*(V1-D1.*U1)./F1-D1p2F1./F2.*T4+T5./F2+l3*E6);
  S2=G2.*(2*l4*(V2-D2.*U1)./F1-D2p2F1./F2.*T4+T6./F2+l3*E7);
  M1=G1.*(E4.*H3./E3sqrt+G2.*D1p2F1);
  M2=G1.*(E5.*H3./E3sqrt+G2.*D2p2F1);
  N1=M1-S1;
  N2=M2-S2;
  
  L1=A1.*K1+A2.*N1-U2.*A1.*D1+E2.*B1-U3.*B2;
  L2=A2.*K2-A1.*N2-U2.*A2.*D2+E2.*C2+U3.*C1;
  L3=A2.*K1-A1.*N1-U2.*A2.*D1+E2.*B2+U3.*B1;
  L4=A1.*K2+A2.*N2-U2.*A1.*D2+E2.*C1-U3.*C2;
  
  Q1=2*A1.^2./F1-1;
  Q2=(mAmA./F2+m3*Q1+2*m4*AAF);
  Q3=(lAlA./F2+l3*Q1+2*l4*AAF);
  x=(A1.*(E0+G4.*Q2)-A2.*G2.*Q3)./F2;
  y=(A2.*(E0+G4.*Q2)+A1.*G2.*Q3)./F2;
end

detJ=(L1.*L2-L3.*L4)./F1;
absdetJ=abs(detJ);

cmx=[]; cmy=[];
tmp=w.*absdetJ;
denom=sum(sum(tmp));
cmx=sum(sum(x.*tmp))./denom; cmx=cmx(:);
cmy=sum(sum(y.*tmp))./denom; cmy=cmy(:);

