function angles=backwardproj(m,p)


% Copyright (C) 2004-2007 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

[theta,phi]=backproject(m,p);
angles=[theta(:) phi(:)];
