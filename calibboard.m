function [cartcoord,bimg,winr,gridsize,fighandle]=calibboard(img)
% [cartcoord,bimg,winr,gridsize]=calibboard(img)
%
% CALIBBOARD is interactive routine that computes the convex hull
% of the polygon marked by the user. The convex hull should cover
% a rectangular grid of control points.
%
% input:
%   img = the calibration image
%
% output:
%   cartcoord = [x0 y0; x1 y1; x2 y2], the approximate pixel
%               coordinates of three corner blobs (0 the origin,
%               1 in x direction, 2 in y direction)
%   bimg = binary image same size as the input image indicating the
%          area of interest (= the convex hull of the polygon)
%   winr = the corners of the smallest rectangle covering the area
%          of interest, [minx miny maxx maxy]'
%   gridsize = the size of the calibration grid inside the area of
%              interest, [nx ny]'
%   fighandle = handle to the current figure

% Copyright (C) 2004-2005 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

button=1;

fighandle=figure;
imshow(img);
hold on;

ip=input('Number of blobs in x-direction: ','s');
nx=str2num(ip);
ip=input('Number of blobs in y-direction: ','s');
ny=str2num(ip);
gridsize=[nx ny]';

counter=0;
disp('Click a polygon that encloses the calibration pattern.');
p=[];
pix=[];

bimg=zeros(size(img));

while button==1
  [x,y,button]=ginput(1);
  if button==1
    counter=counter+1;
    plot(x,y,'m+');
    p=[p;x y];
    
    pixx=ceil(x);
    pixy=ceil(y);
    pix=[pix; pixx pixy];
    bimg(pixy,pixx)=1;
    
    if counter>1
      plot(p(counter-1:counter,1),p(counter-1:counter,2),'m+-');
    end
  end
end
plot(p([1 counter],1),p([1 counter],2),'m+-');

button=3;
disp('Click the origin. (The centre of a control point in some corner of the rectangular grid)');
while button==3
[xin,yin,button]=ginput(1);
end
plot(xin,yin,'m+');

button=3;
disp('Click the centre of the first control point in x-direction');
while button==3
[x1x,x1y,button]=ginput(1);
end
plot(x1x,x1y,'r+');

button=3;
disp('Click the centre of the first control point in y-direction');
while button==3
[y1x,y1y,button]=ginput(1);
end
plot(y1x,y1y,'g+');

stats=regionprops(bimg,'ConvexImage');
bimgs=stats(1).ConvexImage;

minx=min(pix(:,1)); maxx=max(pix(:,1));
miny=min(pix(:,2)); maxy=max(pix(:,2));
winrect=[minx miny; maxx maxy]';
winr=winrect(:);

bimg(miny:maxy,minx:maxx)=double(bimgs);

cartcoord=[xin yin; x1x x1y; y1x y1y];
