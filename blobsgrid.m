function cm=blobsgrid(c,cartcoord,gridsize)
% cm=blobsgrid(c,cartcoord,gridsize)
%
% BLOBSGRID organises the blobs, starting from the corner
% 
% input:
%   c = 2*N-matrix containing the blob centroids
%   cartcoord = [x0 y0; x1 y1; x2 y2], the coordinates of three
%               corner blobs (0 the origin, 1 in x direction, 2 in
%               y direction)
%   gridsize = [nx ny], nx*ny is the number of blobs
%
% output:
%   cm =  ny*nx*2-array, coordinates of the blob centroids
%         organised into a grid
%

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.


N=size(c,2);
nx=gridsize(1); ny=gridsize(2);
cm=zeros(ny,nx,2);

orig=cartcoord(1,:)';
x1=cartcoord(2,:)';
y1=cartcoord(3,:)';

dist=sum((orig*ones(1,N)-c).^2);
[mind,ind]=min(dist);
cco=c(:,ind); c(:,ind)=[];n=N-1;
cm(1,1,:)=cco';

dist=sum((x1*ones(1,n)-c).^2);
[mind,ind]=min(dist);
ccx=c(:,ind); c(:,ind)=[];n=n-1;
cm(1,2,:)=ccx';

dist=sum((y1*ones(1,n)-c).^2);
[mind,ind]=min(dist);
ccy=c(:,ind); c(:,ind)=[];n=n-1;
cm(2,1,:)=ccy';

co=ccx;
v=co-cco;

pairs=[2 3; 1 3; 1 2];
ok=0;
j=1;
for i=2:(nx-1)
  ok=0;
  disto2=sum((co*ones(1,n)-c).^2);
  [disto2,ind]=sort(disto2);
  tmpind=[3 4 5 6 7 8]; tmpcount=1;
  tmpcountmax=length(tmpind);
  
  while ~ok
    cxy=c(:,[ind(1) ind(2) ind(tmpind(tmpcount))]);
   
    vxy=cxy-co*ones(1,3);
    vxyabs=[norm(vxy(:,1)) norm(vxy(:,2)) norm(vxy(:,3))];
      
    for k=1:3
      cosa(k)=vxy(:,pairs(k,1))'*vxy(:,pairs(k,2))/ ...
	      (vxyabs(pairs(k,1))*vxyabs(pairs(k,2)));
      cosb(k)=v'*vxy(:,k)/(vxyabs(k)*norm(v));
    end
    [mincosa, minind]=min(cosa);
    if minind==3
      pair=pairs(minind,:);
      indxy=[ind(pair(1)) ind(pair(2))];	
    else
      pair=pairs(minind,:);
      indxy=[ind(pair(1)) ind(tmpind(tmpcount))];
    end
    ok=1;
    
    if (acos(max(cosb))*180/pi)>25
      if tmpcount<tmpcountmax
	tmpcount=tmpcount+1;
	ok=0;	
      else 
	fprintf('In blobsgrid: Can not find (%d,%d) candidate!\n', 1,i+1);
      end
    end
  end
  
  cxyo=cxy;
  cxy=cxy(:,[pair(1) pair(2)]);
  vxy=vxy(:,[pair(1) pair(2)]); vxy=[vxy; 0 0];
  vtmp=cross(vxy(:,1),vxy(:,2));
  trueminind=pair(1);
  if vtmp(3)<0
    vxy=fliplr(vxy);
    cxy=fliplr(cxy);
    indxy=fliplr(indxy);
    trueminind=pair(2);
  end
  
  [maxcosa,maxind]=max(cosa);
  if maxcosa>cos(5/180*pi) & maxind~=trueminind
    if (cxy(:,1)-cxyo(:,minind))'*v>0
      cxy(:,1)=cxyo(:,minind);
      if minind==3
	indxy(1)=ind(tmpind(tmpcount));
      else
	indxy(1)=ind(minind);
      end
    end
  end
  
  cm(j,i+1,:)=cxy(:,1)';
  
  v=cxy(:,1)-co;
  co=cxy(:,1);
  c(:,indxy(1))=[]; n=n-1;
end

co=ccy;
v=ccy-cco;
i=1;
for j=2:(ny-1)
  ok=0;
  disto2=sum((co*ones(1,n)-c).^2);
  [disto2,ind]=sort(disto2);
  tmpind=[3 4 5 6 7 8]; tmpcount=1;
  tmpcountmax=length(tmpind);
  
  while ~ok
    cxy=c(:,[ind(1) ind(2) ind(tmpind(tmpcount))]);

    vxy=cxy-co*ones(1,3);
    vxyabs=[norm(vxy(:,1)) norm(vxy(:,2)) norm(vxy(:,3))];
      
    for k=1:3
      cosa(k)=vxy(:,pairs(k,1))'*vxy(:,pairs(k,2))/ ...
	      (vxyabs(pairs(k,1))*vxyabs(pairs(k,2)));
      cosb(k)=v'*vxy(:,k)/(vxyabs(k)*norm(v));
    end
    [mincosa, minind]=min(cosa);
    if minind==3
      pair=pairs(minind,:);
      indxy=[ind(pair(1)) ind(pair(2))];	
    else
      pair=pairs(minind,:);
      indxy=[ind(pair(1)) ind(tmpind(tmpcount))];
    end
    ok=1;
    if max(cosb)<cos(30/180*pi)
      if tmpcount<tmpcountmax
	tmpcount=tmpcount+1;
	ok=0;	
      else 
	fprintf('In blobsgrid: Can not find (%d,%d) candidate!\n',j+1,1);
      end
    end
  end
  
  cxyo=cxy;  
  cxy=cxy(:,[pair(1) pair(2)]);
  vxy=vxy(:,[pair(1) pair(2)]); vxy=[vxy; 0 0];
  vtmp=cross(vxy(:,1),vxy(:,2));
  trueminind=pair(1);
  if vtmp(3)>0
    vxy=fliplr(vxy);
    cxy=fliplr(cxy);
    indxy=fliplr(indxy);
    trueminind=pair(2);
  end
  
  [maxcosa,maxind]=max(cosa);
  if maxcosa>cos(5/180*pi) & maxind~=trueminind
    if (cxy(:,1)-cxyo(:,minind))'*v>0
      cxy(:,1)=cxyo(:,minind);
      if minind==3
	indxy(1)=ind(tmpind(tmpcount));
      else
	indxy(1)=ind(minind);
      end
    end
  end
  
  cm(j+1,i,:)=cxy(:,1)';  
  
  v=cxy(:,1)-co;
  co=cxy(:,1);
  c(:,indxy(1))=[]; n=n-1;
end

costol=cos(30/180*pi);
for j=2:ny
  for i=2:nx
    if i==nx & j==ny
      cm(j,i,:)=c';
      
    else
      da2=sum((c-[cm(j-1,i-1,1) cm(j-1,i-1,2)]'*ones(1,n)).^2);
      db2=sum((c-[cm(j-1,i,1) cm(j-1,i,2)]'*ones(1,n)).^2);
      dc2=sum((c-[cm(j,i-1,1) cm(j,i-1,2)]'*ones(1,n)).^2);
      dtot2=da2+db2+dc2;
      [sdtot2,sind]=sort(dtot2);
      %cclose=c(:,sind(1:2));
      if length(sind)>2
	cclose=c(:,sind(1:3));
      else
	cclose=c(:,sind(1:2));
      end
      
      v=[cm(j-1,i,1) cm(j-1,i,2)]'-[cm(j-1,i-1,1) cm(j-1,i-1,2)]';
      vs=cclose-[cm(j,i-1,1) cm(j,i-1,2)]'*ones(1,size(cclose,2));
      %for k=1:2
      for k=1:size(cclose,2)
	cosa(k)=v'*vs(:,k)/ ...
		(norm(v)*norm(vs(:,k)));
      end
      %if cosa(1)<cos(30/180*pi) & cosa(1)<cosa(2)
      %	minind=sind(2);
      %else
      %	minind=sind(1);
      %end
      [mc,mk]=max(cosa);
      if cosa(1)>costol
	minind=sind(1);
      elseif cosa(1)<costol & cosa(2)>costol
	minind=sind(2);
      else
	minind=sind(mk);
      end
      cm(j,i,:)=c(:,minind)';
      
      c(:,minind)=[];n=n-1;
      %plot(cm(j,i,1),cm(j,i,2),'yx');
      %pause(0.5);
    end
  end
end
