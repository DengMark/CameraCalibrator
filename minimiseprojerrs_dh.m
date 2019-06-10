function [p,Rs,ts]=minimiseprojerrs_dh(ms,xs,p0,Rs0,ts0,model,radius)
% [p,Rs,ts]=minimiseprojerrs(ms,xs,p0,Rs0,ts0,model,radius)
%
% MINIMISEPROJERRS optimises the camera parameters (both internal and
% external) by minimising the sum of squared projection errors
%

% Copyright (C) 2004-2006 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

N=length(ms);
intp=p0(:);
extp=[];
for i=1:N
  R0=Rs0{i};
  rotvect=rotationpars_dh(R0); %Öá½Ç±íÊ¾Ðý×ª
  extp=[extp; rotvect(:); ts0{i}];
end

if strcmp(model,'basic')
  PLEN=6;
elseif strcmp(model, 'radial')
  PLEN=9;
elseif strcmp(model, 'extended')
  PLEN=23; 
else
  error('In minimiseprojerrs: Unknown camera model. See sys.model in calibconfig.m.');
end
intplen=length(intp);
if intplen<PLEN
  intp(PLEN)=0;
  intp((intplen+1):PLEN)=1e-7;%0;
end
par0=[intp; extp];

%keyboard
%save par0_v22 par0

options=optimset('LargeScale','off','Algorithm','levenberg-marquardt','Display','iter', 'TolFun',1e-4,'TolX',1e-4,'MaxFunEvals',20000,'MaxIter',1000);
%options=optimset('LargeScale','off','LevenbergMarquardt','on','Display','iter', 'TolFun',1e-3,'TolX',1e-3,'MaxFunEvals',30000,'MaxIter',1000);
%options=optimset('LargeScale','on','LevenbergMarquardt','off','Display','iter', 'TolFun',1e-4,'TolX',1e-4,'MaxFunEvals',30000,'MaxIter',1000);
% 
% disp('Model:');
% disp(model);
% disp('Control point radius:');
% disp(radius);

if isempty(radius) | radius==0
  %disp('In minimiseprojerrs: control points are points with radius 0');
  par=lsqnonlin('projerr_dh',par0,[],[],options,ms,xs,PLEN);    
  
else
  [A,B,W]=makenintmats_dh(radius);
  %disp('In minimiseprojerrs: control points are circular');

  par=lsqnonlin('projerrcircular_dh',par0,[],[],options,ms,xs,PLEN,A,B,W);    
  
end

p=par(1:PLEN);

for i=1:N
  count=PLEN+1+(i-1)*6;
  rotvect=par(count:(count+2));
  ts{i}=par(count+3:count+5);
  Rs{i}=rotationmat_dh(rotvect);
end

%save pars_v22 par0 par Rs ts p0 Rs0 ts0 ms xs model radius
