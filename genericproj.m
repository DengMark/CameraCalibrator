function m=genericproj(X,p,R,t)
% m=genericproj(X,p,R,t)
%
% GENERICPROJ projects points using the generic camera model
%
% input:
%   X = [X Y Z], world coordinates
%   p = [k1 k2 mu mv u0 v0], internal camera parameters
%   R = rotation matrix
%   t = translation vector, Xc'=R*X'+t
%
% output:
%   m = [u v], projected points in pixel coordinates
% 

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

n=size(X,1);

k1=p(1); k2=p(2); mu=p(3); mv=p(4); u0=p(5); v0=p(6);

Xc=R*X'+t*ones(1,n);
Xc=Xc';

theta=acos(Xc(:,3)./sqrt(Xc(:,1).^2+Xc(:,2).^2+Xc(:,3).^2));

r=k1*theta+k2*theta.^3;

% do this to avoid dividing by zero
rXc=sqrt(Xc(:,1).^2+Xc(:,2).^2);
rzero=find(rXc==0);
rXc(rzero)=1;

x=r.*Xc(:,1)./rXc;
y=r.*Xc(:,2)./rXc;

u=mu*x+u0;
v=mv*y+v0;

m=[u v];
