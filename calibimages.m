function calibimages
% CALIBIMAGES  The main routine for manual preprocessing of
% calibration images. If a circular image lens is used the ellipse
% bounding the image field is also located. CALIBIMAGES
% contains two subroutines, PROCESSIMAGES and FINDELLIPSE.  
% 
% See also CALIBCONFIG, PROCESSIMAGES, FINDELLIPSE
%

% Copyright (C) 2004-2006 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.


configname=input('Give the name of your configuration (same as in file calibconfig.m): ','s');

sys=calibconfig(configname);

%imagenames=preprocessimgs(sys);
imagenames=processimages(sys);

if strcmp(sys.circularimage,'yes')
  findellipse(imagenames);
end
