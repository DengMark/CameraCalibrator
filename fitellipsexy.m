function p=fitellipsexy(points)
% p=fitellipsexy(points)
%
% FITELLIPSEXY fits an ellipse to data points assuming that the
% ellipse axes are collinear to the coordinate axes 
% 
% input:
%   points = [x y], n*2-matrix containing the data points
% 
% output:
%   p = [a b x0 y0], ellipse: (u-u0)^2/a^2 + (v-v0)^2/b^2 = 1
%

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

n=size(points,1);
x=points(:,1);
y=points(:,2);

M=[x.^2 y.^2 x y ones(n,1)];
[U,S,V]=svd(M,0);

v=V(:,end);
v=v/v(1);

x0=-0.5*v(3);
y0=-0.5*(v(4)/v(2));
a=sqrt(x0^2+v(2)*y0^2-v(5));
b=sqrt(a^2/v(2));

p=[a b x0 y0];