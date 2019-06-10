function d=projerrcircular_dh(par,ms,xs,PLEN,A,B,W)
% d=projerrcircular(par,ms,xs,PLEN,A,B,W)
%
% See also MINIMISEPROJERRS
%

% Copyright (C) 2004-2006 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

N=length(ms);

p=par(1:PLEN);

if PLEN<23
  p(23)=0;
end
p=p(:);
mu=p(3); mv=p(4); u0=p(5); v0=p(6);
lp=[p(1:2); p(7:end)];

d=[];

for j=1:N
  count=PLEN+1+(j-1)*6;
  
  rotvect=par(count:count+2);
  tj=par(count+3:count+5);
  Rj=rotationmat_dh(rotvect);

  m=ms{j}; x=xs{j};
  M=size(m,1);
  
  for i=1:M
    X=[x(i,1) x(i,2)];
    [xi,yi]=compcentroidcircle_dh(A,B,W,Rj,tj,X,lp);
    ui=mu*xi+u0;
    vi=mv*yi+v0;
    d=[d; m(i,1)-ui; m(i,2)-vi];
  end

end
