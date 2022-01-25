function [pinit,thetamax]=initialiseinternalp_dh(sys)
% [pinit,thetamax]=initialiseinternalp(sys)
%
% INITIALISEINTERNALP initialises the internal camera parameters.
%
% See also CALIBCONFIG

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

thetamax=sys.viewfield/2*pi/180;
theta=0:0.1/180*pi:thetamax;
global f mres
global principalPoint f_dxdy
if strcmp(sys.projtype,'perspective')
  persp=sys.focal*tan(theta);
  [k,mres]=polyfitoddlsq_dh(theta,persp,3);
  k1=k(1); k2=k(3);
elseif strcmp(sys.projtype,'stereographic')
  stereog=2*sys.focal*tan(theta/2);
  [k,mres]=polyfitoddlsq_dh(theta,stereog,3);
  k1=k(3); k2=k(1);
elseif strcmp(sys.projtype,'equidistance')
  equid=sys.focal*theta;
  [k,mres]=polyfitoddlsq_dh(theta,equid,3);
  k1=k(3); k2=k(1);
elseif strcmp(sys.projtype,'equisolidangle')
  equis=2*sys.focal*sin(theta/2);
  [k,mres]=polyfitoddlsq_dh(theta,equis,3);
  k1=k(3); k2=k(1);
elseif strcmp(sys.projtype,'orthographic')
  orthog=sys.focal*sin(theta);
  [k,mres]=polyfitoddlsq_dh(theta,orthog,3);
  k1=k(3); k2=k(1);
else
  error('In initialiseinternalp: Unknown projection type');
end
waitbar(.4,f,sprintf('Average residual: %s model \n %g',sys.projtype,mres));
pause(2)
% fprintf('Average residual of fitting %s model = %g',sys.projtype,mres);
%rmax=k1*thetamax+k2*thetamax^3;

% if isempty(sys.pixelp)   %strcmp(sys.circularimage,'yes')
%   disp('In initialiseinternalp: sys.pixelp empty, ');
%  % load ep;
% %   mu=ep(1)/rmax; mv=ep(2)/rmax;
% %   u0=ep(3); v0=ep(4);
%   mu=286.7999/rmax; mv=261.2379/rmax;
%   u0=320.4951; v0=248.6909;
%   pinit=[k1 k2 mu mv u0 v0];
% else
%   pinit=[k1 k2 sys.pixelp];
% end

 pinit=[k1 k2 sys.pixelp];  %直接利用GUI界面输入的值
% pinit=[k1 k2 f_dxdy/sys.focal principalPoint]; %利用自带标定工具箱解算的参数,测试基本上影响不大
  
if length(pinit)~=6
  error('In initialiseinternalp: Initial guess for p failed. Check sys.pixelp.');
end

