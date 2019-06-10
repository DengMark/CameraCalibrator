function p=imgellipse(img)
% p=imgellipse(img)
%
% IMGELLIPSE returns the parameters of the ellipse bounding
% the image. It is assumed that the image fills an elliptical area
% on black background
%
% input:
%   img = image taken for example with a circular image fish-eye lens
% 
% output:
%   p = [a b u0 v0], ellipse: (u-u0)^2/a^2 + (v-v0)^2/b^2 = 1  
%

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

[ny,nx]=size(img);

fr=1/(ny*nx)*hist(double(img(:)),256);
frs=1/7*filter([1 1 1 1 1 1 1],1,fr);
frsgrad=diff(frs);

Fr=cumsum(frs);
TOL=5/12;
background=Fr<TOL;
cutind=max(find(background));
[minval,th]=min(frsgrad(1:cutind));

if th>10
  disp('In imgellipse: background threshold quite big!');
end

th=(th-1)/256;

bwimg=im2bw(img,th);
[lbw,lnum]=bwlabel(bwimg);
objs=zeros(1,lnum);
for i=1:ny
  for j=1:nx
    if lbw(i,j)~=0
      objs(lbw(i,j))=objs(lbw(i,j))+1;
    end
  end
end
[objss, oind]=sort(objs);
lell=oind(end);

bwimg=zeros(ny,nx);
bwimg(find(lbw==lell))=1;
bwimg=imfill(bwimg,'holes');
regstats=regionprops(bwimg,'BoundingBox','ConvexImage');

bb=regstats(1).BoundingBox;
convimg=regstats(1).ConvexImage;
bwell=zeros(ny,nx);
xc=ceil(bb(1)); dx=bb(3);
yc=ceil(bb(2)); dy=bb(4);
bwell(yc:(yc+dy-1),xc:(xc+dx-1))=convimg;

bwell=bwperim(bwell);
bwell(1,:)=0; bwell(ny,:)=0; bwell(:,1)=0; bwell(:,nx)=0;

[pointsi,pointsj]=find(bwell);
points=[pointsj pointsi];
p=fitellipsexy(points);





