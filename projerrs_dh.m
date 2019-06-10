function [err,meanerr,mederr,su,sv,rmserr]=projerrs_dh(ms,xs,p,Rs,ts,radius)

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

p=p(:);

if length(p)<23
  p(23)=0;
end
mu=p(3); mv=p(4); u0=p(5); v0=p(6);
lp=[p(1:2); p(7:23)];

N=length(ms);
du=[]; dv=[];
d=[];
for j=1:N
  m=ms{j};
  x=xs{j};
  M=size(m,1);
  errj=zeros(1,M);
  
  if isempty(radius) | radius==0
    mh=genericprojextended_dh([x(:,1) x(:,2) zeros(M,1)],p,Rs{j},ts{j});
    dm=m'-mh';
    du=[du; dm(1,:)'];
    dv=[dv; dm(2,:)'];
    errj=sqrt(sum(dm.^2));  %存放每一个点 反投影像素误差（按照初始值p0，R0,t0反投影）
  else
    [A,B,W]=makenintmats_dh(radius);
    for i=1:M
      X=[x(i,1) x(i,2)];
      [xi,yi]=compcentroidcircle_dh(A,B,W,Rs{j},ts{j},X,lp);
      ui=mu*xi+u0;
      vi=mv*yi+v0;
      du=[du; m(i,1)-ui];
      dv=[dv; m(i,2)-vi];
      errj(i)=norm([m(i,1)-ui; m(i,2)-vi]);
    end
  end
  
  d=[d errj];
  err{j}=errj; %存放每一帧反投影误差
  meanerr(j)=mean(errj); %存放每一帧反投影误差均值
end

su=std(du);  %u偏差
sv=std(dv);  %v偏差
meanerr=mean(meanerr);
mederr=median(d);
rmserr=sqrt(mean(d.^2));
