function [blobimg,th]=findblobs(img, bimg, winr, blobcolor, th)
% blobimg=findblobs(img, bimg, winr, blobcolor, th)
%
% FINDBLOBS finds the appropriate threshold value (if not given)
% and thresholds the calibration image to determine the positions
% of the circular control points
%
% input:
%   img = the calibration image
%   bimg = binary image indicating the area of interest in img
%   winr = corners of the smallest rectangle covering the area of
%          interest 
%   blobcolor = 'black' or 'white'
% optional:
%   th = threshold value
%
% output:
%   blobimg = binary image where the objects correspond to areas
%             below (blobcolor='black') or above
%             (blobcolor='white') the threshold value
%

% Copyright (C) 2004-2005 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

if nargin<4 | isempty(blobcolor)
  blobcolor='black';
end
if nargin<5 
  th=[];
end

[r,c]=size(img);


boardimg=bimg.*double(img);
board=boardimg(winr(2):winr(4),winr(1):winr(3));
board=uint8(board);
if isempty(th)
  th=thresholdbayes(boardimg(find(bimg)));
end
blobs=im2bw(board,th);
if strcmp(blobcolor,'white')
else
  blobs=~blobs;
end

blobimg=zeros(size(img));
blobimg(winr(2):winr(4),winr(1):winr(3))=blobs;
blobimg=logical(blobimg);
blobimg=blobimg & bimg;
