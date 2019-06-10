function [Rs,ts]=optimiseexternal(ms,xs,p,Rs0,ts0,model,radius)

% [p,Rs,ts]=minimiseprojerrs(ms,xs,p0,Rs0,ts0,model,radius)
%
% MINIMISEPROJERRS optimises the camera parameters (both internal and
% external) by minimising the sum of squared projection errors
%

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

N=length(ms);

extp=[];
for i=1:N
  R0=Rs0{i};
  %[w,ntheta,nphi]=rotmatdecomp(R0);
  rotp=rotationpars(R0);
  extp=[extp; rotp(:); ts0{i}];
end

options=optimset('LargeScale','off','LevenbergMarquardt','on','Display','iter', 'TolFun',1e-4,'TolX',1e-4,'MaxFunEvals',20000,'MaxIter',1000);

if isempty(radius) | radius==0
  par=lsqnonlin('projerrext',extp,[],[],options,p,ms,xs);
else
  [A,B,W]=makenintmats(radius);
  
  par=lsqnonlin('projerrcircularext',extp,[],[],options,p,ms,xs,A,B,W);  
end

for i=1:N
  count=1+(i-1)*6;
  rotvect=par(count:(count+2));
  ts{i}=par(count+3:count+5);

  Rs{i}=rotationmat(rotvect);
end
