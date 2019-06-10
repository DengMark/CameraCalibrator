function [cmatnew,blobsext]=blobsgrayscale(img,blobs,cmat,blobcolor)
% BLOBSGRAYSCALE computes the blob centroids by weighting the
% pixels with their grayscale values
%

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

se=strel('disk',1,0);
nx=size(cmat,2);
ny=size(cmat,1);
dx=size(img,2);
dy=size(img,1);
blobsext=zeros(dy,dx);
[X,Y]=meshgrid(1:dx,1:dy);
lb=bwlabel(blobs);
dimg=double(img);

cmatnew=zeros(ny,nx,2);
blobji=zeros(dy,dx);blobjiext=zeros(dy,dx);blobjiimg=zeros(dy,dx);

%disp('No dilation in blobsgrayscale');

for j=1:ny
  for i=1:nx
    %lb=bwlabel(blobs);
    num=lb(ceil(cmat(j,i,2)),ceil(cmat(j,i,1)));
    blobji=(lb==num);
    blobjiext=imdilate(blobji,se);
    bjiind=find(blobjiext);
    blobsext=(blobsext | blobjiext);
    if strcmp(blobcolor,'white')
      minval=min(double(img(bjiind)));
      blobjiimg=double(blobjiext).*(dimg-minval);
    else
      maxval=max(double(img(bjiind)));
      blobjiimg=double(blobjiext).*(maxval-dimg);
    end
    %[X,Y]=meshgrid(1:dx,1:dy);
    blobjiimgs=sparse(blobjiimg);
    ss=full(sum(sum(blobjiimgs)));
    cmatnew(j,i,1)=(sum(sum(X.*blobjiimgs))/ss);
    cmatnew(j,i,2)=(sum(sum(Y.*blobjiimgs))/ss);
  end
end


