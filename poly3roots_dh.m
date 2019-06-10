function r=poly3roots_dh(a3,a2,a1,a0)
% r=poly3roots(a3,a2,a1,a0)
%
% POLY3ROOTS solves simultaneously a set of cubic equations
%
% input:
%   ai = N-vector containing the i:th coefficients of the cubic equations
%        a3 MUST BE FREE OF ZEROS! 
% 
% output:
%   r = 3*N-matrix containing the roots of each equation
%

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

tmpa=a2./a3;
p=a1./a3-1/3*tmpa.^2;
q=2/27*tmpa.^3-1/3*(a1.*a2)./(a3.^2)+a0./a3;
D=1/27*p.^3+1/4*q.^2;
dplus=(D>=0);
dminus=(D<0);
tmp1=(-1/2*q+sqrt(D));
tmp2=(-1/2*q-sqrt(D));
u=dplus.*sign(tmp1).*(abs(tmp1)).^(1/3);
v=dplus.*sign(tmp2).*(abs(tmp2)).^(1/3);
u=u+dminus.*tmp1.^(1/3);
v=v+dminus.*tmp2.^(1/3);
r(1,:)=-1/3*tmpa+u+v;
r(2,:)=-1/3*tmpa-1/2*(u+v)+(sqrt(3)/2*i)*(u-v);
r(3,:)=-1/3*tmpa-1/2*(u+v)-(sqrt(3)/2*i)*(u-v);
