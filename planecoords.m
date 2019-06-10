function coordmat=planecoords(nx,ny,dx,dy)
% coordmat=planecoords(nx,ny,dx,dy)
%
% PLANECOORDS generates the coordinates of the control points in the
% calibration plane.
%
% input:
%   nx = number of control points in x direction
%   ny = number of control points in y direction
%   dx = distance between control points in x direction
%   dy = distance between control points in y direction   
%
% output:
%   coordmat = ny*nx*2-matrix containing the x and y coordinates of
%              the control points
%

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

coordmat=zeros(ny,nx,2);

for j=1:ny
  for i=1:nx
    coordmat(j,i,:)=[(i-1)*dx (j-1)*dy]';
  end
end

