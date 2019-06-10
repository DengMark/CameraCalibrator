function [SUCCESS, cmat, blobsnew]=arrangeblobs(blobs, gridsize,cartcoord)
% [SUCCESS, cmat, blobsnew]=arrangeblobs(blobs, gridsize,cartcoord)
%
% ARRANGEBLOBS computes the blob centroids (from thresholded binary
% image) and organises them into a rectangular grid (using
% subroutine BLOBSGRID)
% 
% input:
%   blobs = binary image, each blob should be an object
%   gridsize = [nx ny], nx*ny is the number of blobs
%   cartcoord = [x0 y0; x1 y1; x2 y2], the coordinates of three
%               corner blobs (0 the origin, 1 in x direction, 2 in
%               y direction)
%
% output:
%   SUCCESS = 1, if everything goes fine, otherwise 0
%   cmat =  ny*nx*2-array, coordinates of the blob centroids
%           organised into a grid
%   blobsnew = binary image, containing only nx*ny objects
%
% See also BLOBSGRID

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.


nx=gridsize(1);
ny=gridsize(2);

[lb,num]=bwlabel(blobs,4);
ind=cell(1,num);

if num>(nx*ny)  % if too many "blobs" take only the largest
  a=zeros(1,num);
  for j=1:num
    ind{j}=find(lb==j);
    a(j)=length(ind{j});
  end
  [as, aind]=sort(a);
  for j=1:(num-(nx*ny))
    lb(ind{aind(j)})=0;
  end
  blobsnew=min(1,lb);
  [lb,num]=bwlabel(blobsnew,4);
  if num~=(nx*ny)
    disp('In arrangeblobs: Number of blobs is not right!');
    SUCCESS=0;blobsnew=blobs;cmat=[];
    return;
  end
elseif num<(nx*ny)
  disp('In arrangeblobs: All blobs not found!');
  SUCCESS=0;blobsnew=blobs;cmat=[];
  return;
else
  blobsnew=blobs;
end


% compute the centroids
centers=regionprops(lb,'Centroid');
for j=1:num
  c(:,j)=(centers(j).Centroid)';
end

% organise
cmat=blobsgrid(c,cartcoord,gridsize);
SUCCESS=1;
