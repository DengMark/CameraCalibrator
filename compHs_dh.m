function [Hs,err_homo]=compHs_dh(p,ms,xs,thetamax)

% Copyright (C) 2004-2005 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

N=length(ms);  % total N views
%A=[];
 err_homo = zeros(1,N);
 Hs= cell(1,N);
for i=1:N
  x=generic2sphere_dh(ms{i},p,thetamax);
  xp=[xs{i} ones(size(xs{i},1),1)];
  % initial estimate for Hs from correspondences xp<->x by linear algorithm with data normalization
  H0=homdltps_dh([xp x]);  
  %options=optimset('LargeScale','off','Algorithm','levenberg-marquardt', 'Display','iter','MaxFunEvals',10000,'TolX',1e-4,'TolFun',1e-4);
   options_dh=optimoptions(@lsqnonlin,'Algorithm','levenberg-marquardt', 'Display','iter');
  [H,resnorm,res]=lsqnonlin(@homangleerr_dh,H0,[],[],options_dh,x,xp);
% [H]=lsqnonlin(@homangleerr_dh,H0,[],[],options_dh,x,xp);
   err_homo(i)=mean(abs(res));
  %err{i}=mean(abs(res));
  %err{1,i}=num2cell(mean(abs(res)));
  Hs{i}=H;
end

