function [imu,bpdata,K]=undistort(im,p,thetamax,f,subpixelstep)
% [imu,bpdata,K]=undistort(im,p,thetamax,f,subpixelstep)
%
% UNDISTORT corrects the images to follow the pinhole model.
% Meaningful only for cameras having a field of view less than 180 degrees. 
%
% input:
%   im = the original image
%   p  = the internal camera parameters
%   thetamax = maximum value for the theta angle in radians,
%              this does not affect the accuracy, use some reasonable
%              value (rather too large than too small)
% optional input:
%   f =  the focal length of the pinhole camera corresponding to
%        the corrected image
%   subpixelstep = if smaller than 1 (default) the rays are backprojected
%                  at a subpixel level (may affect the accuracy)
% 
% output:
%   imu = the corrected image
%   bpdata = [x y theta phi], the pixel coordinates and the
%            corresponding directions of backprojected rays
%   K = the calibration matrix of the pinhole camera corresponding
%       to the corrected image

% Copyright (C) 2006 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.

camera_parameters=p(:)';
  
if nargin<4 | isempty(f)
  f=p(1);
  m_u=p(3); m_v=p(4);
  u0=p(5); v0=p(6);
end
if nargin<5 | isempty(subpixelstep)
  subpixelstep=1;%0.5;
end

  
[m,n]=size(im);
yg=1:subpixelstep:m;
xg=1:subpixelstep:n;
lyg=length(yg);
lxg=length(xg);

[Xm,Ym]=meshgrid(xg,yg);
x=Xm(:); y=Ym(:); v=im(:);

disp('In undistort.m: Computing backprojections for pixels ...');

[theta,phi]=backproject([x y],p,thetamax);

bpdata=[x y theta phi];
disp('In undistort.m: Original image backprojected');

rph=tan(theta);
xc=m_u*f*rph.*cos(phi)+u0; yc=m_v*f*rph.*sin(phi)+v0;

minxc=floor(min(xc)); maxxc=ceil(max(xc));
minyc=floor(min(yc)); maxyc=ceil(max(yc));

[Xmc,Ymc]=meshgrid(minxc:maxxc,minyc:maxyc);

disp('In undistort.m: Rays reprojected with a pinhole camera. Interpolating...');

if subpixelstep==1
  img=double(im);
else
  img=double(imresize(im,[lyg lxg],'bilinear'));
end

imu=griddata(reshape(xc,lyg,lxg),reshape(yc,lyg,lxg),img,Xmc,Ymc);

bpdata=[x y theta phi xc yc];

K=[1 0 -minxc+1; 0 1 -minyc+1; 0 0 1]*[f*m_u 0 u0; 0 f*m_v v0; 0 0 1];

%keyboard
