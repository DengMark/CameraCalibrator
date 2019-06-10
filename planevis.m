function fh=planevis(img,bimg,cartcoord)
% PLANEVIS displays the convex region marked by the user
%

% Copyright (C) 2004-2005 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

%ny=size(cmat,1);
%nx=size(cmat,2);

fh=figure; 
imshow(img); hold on
%cx=cmat(:,:,1); cy=cmat(:,:,2);
%c=[cx(:) cy(:)];
%plot(c(:,1),c(:,2),'r+');
set(gcf,'DefaultTextColor','magenta');
text(cartcoord(1,1),cartcoord(1,2),'O');
text(cartcoord(2,1),cartcoord(2,2),'X');
text(cartcoord(3,1),cartcoord(3,2),'Y');
bimgperim=bwperim(bimg);
[bbl,num]=bwlabel(bimgperim);
for i=1:num
  [indy,indx]=find(bbl==i);
  plot(indx,indy,'r.');
end
