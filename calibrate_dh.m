function [p,Rs,ts,err]=calibrate_dh(sys,ms,xs,pinit)
% [p,Rs,ts]=calibrate(ms,xs)
%
% CALIBRATE computes the optimal camera parameters. Without any
% input the calibration data is read from the files supplied by
% CALIBIMAGES 
% 
% optional input:
%   configname = the name for the setup, see CALIBCONFIG 
%   ms = the measured control point positions in each image, 
%        cell array of matrices containing two columns
%   xs = the control point positions in the calibration plane,
%        cell array of matrices containing two columns
%
% output:
%   p = the internal camera parameters, whose number depends on the
%       camera model (6, 9 or 23)
%   Rs = cell array, Rs{j} is the rotation matrix for view j
%   ts = cell array, ts{j} is the translation vector for view j
%
% See also CALIBCONFIG, CALIBIMAGES
%

% Copyright (C) 2004-2006 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.


global f
global p0 Rs0 ts0
global meanerr rmserr su sv thetamax_first thetamax maxd meand
% if nargin<3 | isempty(xs) | isempty(ms)
%   [ms,xs]=readdata(sys);
% end
if nargin<4
  pinit=[];
end
waitbar(.3,f,'Initialization of internal parameters...');
pause(1)
if isempty(pinit)
  [pinit,thetamax]=initialiseinternalp_dh(sys);
else
  thetamax=sys.viewfield/2*pi/180;
end
p0=pinit;
waitbar(.5,f,'Back-projection and computation of homographies...');
pause(1)
% disp('Computation of homographies...');
[Hs, err_homo]=compHs_dh(p0,ms,xs,[]);
%err_single=err_single
% fprintf('err:%g\n',err_single)
K=eye(3);
waitbar(.6,f,'Initialization of external parameters...');
pause(1)
% disp('Initialises the external camera parameters...');
[Rs0,ts0]=initialiseexternalp_dh(Hs,K,sys.cata);

waitbar(.7,f,'Computation of projection error...');
pause(1)
disp('Computation of projection error...');
[err_b,meanerr]=projerrs_dh(ms,xs,p0,Rs0,ts0,sys.blobradius);

%keyboard;
waitbar(.8,f,sprintf('Error between measured and modelled points\n %.4f pixels',meanerr));
pause(1)
disp('Mean distance between measured and modelled centroids before nonlinear minimization')
fprintf(1,' %.4f pixels\n',meanerr);

%keyboard
% first just the basic model  
%if length(p0)<7
waitbar(.9,f,'Optimise the total camera parameters...');
pause(1)
%最优化算法
[p,Rs,ts]=minimiseprojerrs_dh(ms,xs,p0,Rs0,ts0,sys.model,0);
p=p

% if the initial guess is bad the general radially symmetric
% projection may give negative values for r and we need the
% following correction
if p(1)<0 | (p(1)==0 & p(2)<0)
  disp('In calibcomp: Radius must be positive');
  p(1)=-p(1); p(2)=-p(2);
  S=[-1 0 0; 0 -1 0; 0 0 1];
  for i=1:length(Rs)
    R=Rs{i};
    Rs{i}=S*Rs{i};
    ts{i}=S*ts{i};
  end
end

% if a more complex model is assumed or the control points are circular
% if ~strcmp(sys.model,'basic') | sys.blobradius~=0
%   [err,meanerr]=projerrs_dh(ms,xs,p,Rs,ts,sys.blobradius);
%   disp('Mean distance between measured and modelled centroids before fitting the full model')
%   fprintf(1,' %.4f pixels\n\n',meanerr);
%   disp('If the control points are circular the computation may take time. Computing ...');
%   [p,Rs,ts]=minimiseprojerrs_dh(ms,xs,p,Rs,ts,sys.model,sys.blobradius);
% end

waitbar(.95,f,'Computate the projection error...');
pause(1)
%计算优化参数后的反投影误差
[err,meanerr,mederr,su,sv,rmserr]=projerrs_dh(ms,xs,p,Rs,ts,sys.blobradius);

disp('Mean distance between measured and modelled centroids:')
fprintf(1,' %.4f pixels\n',meanerr);

disp('RMS distance between measured and modelled centroids:')
fprintf(1,' %.4f pixels\n',rmserr);

disp('Standard deviation of the residuals:');
fprintf(1,'sigma_u: %.4f pixels\n',su);
fprintf(1,'sigma_v: %.4f pixels\n',sv);

%计算径向投影模型p的准确程度
%r=f(theta,p) thetamax_first为一直递增到的最大theta,thetamax_global为r最大对应的theta
[thetamax_first, thetamax_global]=examineradialprojection_dh(p);
if isempty(thetamax_first)
  thetamax_first=thetamax_global;
end

fprintf(1,'Radial projection curve is increasing up to %f degrees.\n',thetamax_first/pi*180);
%thetamax为给定的视场角一半
fprintf(1,'The initial value for thetamax given in calibconfig was %f degrees,\n',thetamax/pi*180);

[maxd,meand]=testbackproject_dh(p,min(thetamax,thetamax_first));

%save(filename,'ms','xs','p0','Rs0','ts0','p','Rs','ts','err','meanerr','mederr','su','sv','maxd','meand','rmserr','sys');

disp('The backward model error:');
fprintf(1,'maximum reprojection error: %e pixels\n',maxd);
fprintf(1,'mean reprojection error: %e pixels\n',meand);

