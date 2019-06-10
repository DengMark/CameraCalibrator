function fighandle=blobvis_update(img,blobs,bimg,fighandle)
% BLOBVIS_UPDATE displays the result of thresholding
%

% Copyright (C) 2004-2005 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

if nargin<4 | isempty(fighandle)
  fighandle=figure; 
else
  figure(fighandle);
end

clf;
imshow(img); hold on

bimgperim=bwperim(blobs,8);
[bbl,num]=bwlabel(bimgperim);
[indy,indx]=find(bbl);
plot(indx,indy,'r.');
%for i=1:num
%  [indy,indx]=find(bbl==i);
%  plot(indx,indy,'r.');
%end

bimgperim=bwperim(bimg,8);
[bbl,num]=bwlabel(bimgperim);
[indy,indx]=find(bbl);
plot(indx,indy,'r.');
%for i=1:num
%  [indy,indx]=find(bbl==i);
%  plot(indx,indy,'r.');
%end
