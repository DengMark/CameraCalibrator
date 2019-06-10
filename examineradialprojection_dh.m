function [thetafirstmax, thetamax]=examineradialprojection_dh(p)

% Copyright (C) 2004-2007 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.



ts=[0:0.5:180]/180*pi;

if length(p)>=9
  k1=p(1); k2=p(2); k3=p(7); k4=p(8); k5=p(9);
  rc=[k5 0 k4 0 k3 0 k2 0 k1 0];
  dc=[9*k5 0 7*k4 0 5*k3 0 3*k2 0 k1];
else
  k1=p(1); k2=p(2);
  rc=[k2 0 k1 0];
  dc=[3*k2 0 k1];
end
 %y = polyval(p,x) 计算多项式 p 在 x 的每个点处的值。
 %参数 p 是长度为 n+1 的向量，其元素是 n 次多项式的系数（降幂排序）： 
rs=polyval(rc,ts); % rs = k5*x^9+k4*x^7+k3*x^5+k2*x^3+k1*x
ds=polyval(dc,ts); % ds = 9*k5*x^8+7*k4*x^6+5*k3*x^4+3*k2*x^2+k1*x ,rs求导

[maxr,maxid]=max(rs);
thetamax=ts(maxid);

negderiv=find(ds<0);
thetafirstmax=ts(min(negderiv));

