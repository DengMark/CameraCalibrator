function d=projerr_dh(par,ms,xs,PLEN)
% d=projerr(par,ms,xs,PLEN) 
%
% See also MINIMISEPROJERRS
%

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

N=length(ms);

p=par(1:PLEN);
d=[];

for i=1:N
  count=PLEN+1+(i-1)*6;
  rotvect=par(count:count+2);
  ti=par(count+3:count+5);
  
  Ri=rotationmat(rotvect);  %轴角表示到旋转矩阵表示

  M=size(ms{i},1);
  mh=genericprojextended_dh([xs{i} zeros(M,1)],p,Ri,ti);
  m=ms{i};
  err=m'-mh';
  d=[d; err(:)];
end
