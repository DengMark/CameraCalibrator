function [r,phi]=xy2rphi_dh(x,y)
%
%

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.


r=sqrt(x.^2+y.^2);

indx0=find(x==0);
indxneg=find(x<0);
x(indx0)=1;

phi=atan(y./x);
phi(indxneg)=phi(indxneg)+pi;
phi(indx0)=sign(y(indx0)).*pi/2;

phineg=find(phi<0);
phi(phineg)=2*pi+phi(phineg);


