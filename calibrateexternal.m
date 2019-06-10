function [p,Rs,ts,err]=calibrateexternal(configname,p,ms,xs,filename)
% [p,Rs,ts,err]=calibrateexternal(p,ms,xs)
%
% This function optimises only the external parameters. The
% internal parameters p must be given as input. 
% 
% See also CALIBRATE
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

if nargin<1 | isempty(configname)
configname=input('Give the name of your configuration (the name given in file calibconfig.m): ','s');
end
%configname=input('Give the name of your configuration (the name given in file calibconfig.m): ','s');
sys=calibconfig(configname);

if nargin<4 | isempty(xs) | isempty(ms)
  [ms,xs]=readdata(sys);
end
  
thetamax=sys.viewfield/2*pi/180;

[Hs,err]=compHs(p,ms,xs,thetamax);
err=err

K=eye(3);

[Rs0,ts0]=initialiseexternalp(Hs,K,sys.cata);

[err,meanerr]=projerrs(ms,xs,p,Rs0,ts0,sys.blobradius);

%keyboard;

disp('Mean distance between measured and modelled centroids before nonlinear minimization')
fprintf(1,' %.4f pixels\n',meanerr);

[Rs,ts]=optimiseexternal(ms,xs,p,Rs0,ts0,sys.model,sys.blobradius);

[err,meanerr,mederr,su,sv,rmserr]=projerrs(ms,xs,p,Rs,ts,sys.blobradius);
  
disp('Mean distance between measured and modelled centroids:')
fprintf(1,' %.4f pixels\n',meanerr);

disp('RMS distance between measured and modelled centroids:')
fprintf(1,' %.4f pixels\n',rmserr);

disp('Standard deviation of the residuals:');
fprintf(1,'sigma_u: %.4f pixels\n',su);
fprintf(1,'sigma_v: %.4f pixels\n',sv);

if nargin<4 | isempty(filename)
 filename='extpars.mat'
end
save(filename,'ms','xs','Rs0','ts0','p','Rs','ts','err','meanerr','mederr','su','sv','rmserr','sys');
