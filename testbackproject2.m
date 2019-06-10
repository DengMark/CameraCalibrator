function [maxd,meand,rmserr]=testbackproject2(p,imsize,thetamax)

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

mu=p(3); mv=p(4); u0=p(5); v0=p(6);
if length(p)<9
  ks=[p(1) p(2) 0 0 0];
else
  ks=[p(1) p(2) p(7) p(8) p(9)];
end

%thetamax=1.05*thetamax;

rmax=ks(1)*thetamax+ks(2)*thetamax^3+ks(3)*thetamax^5+ks(4)* ...
     thetamax^7+ks(5)*thetamax^9;
rmax=abs(rmax);
a=mu*rmax; b=mv*rmax;

[X,Y]=meshgrid(1:imsize(1),1:imsize(2));
u=X(:);
v=Y(:);

indin=find((((u-u0)/a).^2+((v-v0)/b).^2)<1);
pixs=[u(indin) v(indin)];

if 0
imtest=zeros(imsize(2),imsize(1));
imtest(indin)=1;
figure;
imshow(imtest);
keyboard
end

[theta,phi]=backproject(pixs,p,1.1*thetamax);
Xc=[cos(phi).*sin(theta) sin(phi).*sin(theta) cos(theta)];

if length(p)<23
  p(23)=0;
end
m=genericprojextended(Xc,p,eye(3),zeros(3,1));

d=sqrt(sum((m-pixs).^2,2));
maxd=max(d);
meand=mean(d);    
rmserr=sqrt(mean(sum((m-pixs).^2,2)));
