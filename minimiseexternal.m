function [Rs,ts]=minimiseexternal(ms,xs,p,Rs0,ts0,model,radius)

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
  [w,ntheta,nphi]=rotmatdecomp(R0);
  extp=[extp; w; ntheta; nphi; ts0{i}];
end

options=optimset('LargeScale','off','LevenbergMarquardt','on','Display','iter', 'TolFun',1e-4,'TolX',1e-4,'MaxFunEvals',30000,'MaxIter',1000);

if isempty(radius) | radius==0
  disp('In minimiseexternal: not implemented');
else
  [A,B,W]=makenintmats(radius);
  
  if strcmp(model,'basic')
    disp('In minimiseexternal: not implemented');
    %par=lsqnonlin('projerrbasiccircular',par0,[],[],options,ms,xs,A,B,W);
  elseif strcmp(model, 'radial')
    par=lsqnonlin('projerrradialcircularext',extp,[],[],options,p,ms,xs,A,B,W);    
  elseif strcmp(model, 'extended')
    par=lsqnonlin('projerrextendedcircularext',extp,[],[],options,p,ms,xs,A,B,W);
  else
    error('In minimiseprojerrs: Unknown camera model. See sys.model in calibconfig.m.');
  end
  
end

for i=1:N
  count=1+(i-1)*6;
  rotvect=par(count:(count+2));
  ts{i}=par(count+3:count+5);
  w=rotvect(1);
  n=[sin(rotvect(2))*cos(rotvect(3)) sin(rotvect(2))*sin(rotvect(3)) ...
     cos(rotvect(2))]';
  Nx=[0 -n(3) n(2); n(3) 0 -n(1); -n(2) n(1) 0];
  Rs{i}=n*n'+cos(w)*(eye(3)-n*n')+sin(w)*Nx;
end