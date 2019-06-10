function [A,B,W]=makenintmats_dh(radius, n)
% [A,B,W]=makenintmats(radius, n)
%
% MAKENINTMATS forms the matrices that are used when the centroids
% of the projected circles are computed by numerical integration
%
% input:
%   radius = radius of the circles
% optional:
%   n = we use 3n*3n grid in parameterspace [0,2*pi]x[0,radius],
%       default n=8 
%
% output:
%   A = values of alpha angle at grid points
%   B = values of radius parameter at grid points
%   W = weights at grid points, the weighted sum gives the same
%       result as exact integration of bicubic interpolation function
%

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

if nargin<2
  n=8;
end

v=radius/(3*n);
u=2*pi/(3*n);

b=0:v:radius;
lenb=length(b);
if lenb>(3*n+1)
  b=b(1:(3*n+1));
elseif lenb<(3*n+1)
  if lenb==3*n
    b=[b b(end)+v];  
  else
    disp('In makeintmats: integration grid not right');
  end
else  
end

a=0:u:(2*pi);
lena=length(a);
if lena>(3*n+1)
  a=a(1:(3*n+1));
elseif lena<(3*n+1)
  if lena==3*n
    a=[a a(end)+u];  
  else
    disp('In makeintmats: integration grid not right');
  end
else  
end

lena=length(a);
lenb=length(b);

[A,B]=meshgrid(a,b);
%W=zeros(3*n+1,3*n+1);

row1=[];
blockrow=[];
block=[9 9 6; 9 9 6; 6 6 4];
blocklast=[9 9 6; 9 9 6; 3 3 2];
rowslast=[];
for k=1:(n-1)
  row1=[row1 3 3 2];
  blockrow=[blockrow block];
  rowslast=[rowslast blocklast]; 
end

row1=[1 row1 3 3 1];

blockend=[9 9 3; 9 9 3; 6 6 2];
blockrow=[[3;3;2] blockrow blockend];

blocklastend=[9 9 3; 9 9 3; 3 3 1];
rowslast=[[3;3;1] rowslast blocklastend];

W=[];
for k=1:(n-1)
  W=[W; blockrow];
end

W=radius*2*pi/(64*n^2)*[row1; W; rowslast];


