function d=projerrext(par,p,ms,xs)

% Copyright (C) 2004-2006 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

N=length(ms);

d=[];

for j=1:N
  count=1+(j-1)*6;

  rotvect=par(count:count+2);
  tj=par(count+3:count+5);
  Rj=rotationmat(rotvect);
  
  m=ms{j}; x=xs{j};
  M=size(m,1);

  mh=genericprojextended([xs{j} zeros(M,1)],p,Rj,tj);
  err=m'-mh';
  d=[d; err(:)];
end
