function [maxd,meand,rmserr]=testbackproject_dh(p,thetamax)

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

rmax=ks(1)*thetamax+ks(2)*thetamax^3+ks(3)*thetamax^5+ks(4)* ...
     thetamax^7+ks(5)*thetamax^9;
rmax=abs(rmax);
%产生区间（-rmax,rmax）间5000个随机数
x=2*rmax*rand(5000,1)-rmax;
y=2*rmax*rand(5000,1)-rmax;

X=[x y];
r=sqrt(sum(X.^2,2));
ind=find(r>rmax);
X(ind,:)=[];

x=X(:,1); y=X(:,2);
u=mu*x+u0;
v=mv*y+v0;

%[theta,phi]=backproject_dh([u v],p,1.05*thetamax);
[theta,phi]=backproject_dh([u v],p,thetamax);
Xc=[cos(phi).*sin(theta) sin(phi).*sin(theta) cos(theta)];

if length(p)<23
  p(23)=0;
end
m=genericprojextended_dh(Xc,p,eye(3),zeros(3,1)); %反投影到uv

d=sqrt(sum((m-[u v]).^2,2));
maxd=max(d);
meand=mean(d);    
rmserr=sqrt(mean(sum((m-[u v]).^2,2)));
