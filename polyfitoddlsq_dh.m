function [p, mres,a]=polyfitoddlsq_dh(x,y,n)
% [p, mres,a]=polyfitoddlsq(x,y,n)
%
% POLYFITODDLSQ fits an odd polynomial of degree n to data with the
% least squares method.
%
% input:
%   x = x coordinates in a vector 
%   y = corresponding y coordinates
%
% output:
%   p = coefficients of the fitted polynomial p=[c_n ... c_0]
%   mres = average residual E[y-p(x)]
%   a = only the coefficients of odd terms a=[c_1 c_3 ... c_n]

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

x=x(:); y=y(:);
M=length(x);
pows=1:2:n;
nodd=length(pows);
X=[];
for i=pows
  X=[X x.^i];
end

a=inv(X'*X)*X'*y;

mres=1/M*norm(y-X*a);

counter=0;
for i=1:(n+1)
  if 2*floor(i/2)==i
    p(i)=0;
  else
    p(i)=a(nodd-counter);
    counter=counter+1;
  end
end


