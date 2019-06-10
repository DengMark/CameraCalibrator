function fh=blobvis(img,blobs,cmat)
% BLOBVIS displays the blobs and their centroids
%

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

ny=size(cmat,1);
nx=size(cmat,2);

fh=figure; 
imshow(img); hold on
%cx=cmat(:,:,1); cy=cmat(:,:,2);
%c=[cx(:) cy(:)];
%plot(c(:,1),c(:,2),'r+');
bimgperim=bwperim(blobs,8);
[bbl,num]=bwlabel(bimgperim);
[indy,indx]=find(bbl);
plot(indx,indy,'r.');
%for i=1:num
%  [indy,indx]=find(bbl==i);
%  plot(indx,indy,'r.');
%end

if ~isempty(cmat)
cx=cmat(:,:,1); cy=cmat(:,:,2);
c=[cx(:) cy(:)];
plot(c(:,1),c(:,2),'r+');
for k=1:nx
  for l=1:ny
    set(gcf,'DefaultTextColor','magenta');
    ks=num2str(k);
    ls=num2str(l);
    str=[ls ', ' ks];
    text(cmat(l,k,1)+2,cmat(l,k,2),str);
    end
end
end
