function H=homdltps_dh(mh)


% INPUT:
%  mh = [m1x m1y m1w m2x m2y m2w], n*6-matrix for matched points,
%      mh1 points in the plane Z=1, mh2 points on the unit sphere 
% OUTPUT:
%  H = homography, 3*3-matrix

n=size(mh,1);
%分别对mh1,mh2归一化
m1=mh(:,1:3);
m1norm=sqrt(sum(m1.^2,2));
m1=m1./(m1norm*ones(1,3));

m2=mh(:,4:6);
m2norm=sqrt(sum(m2.^2,2));
m2=m2./(m2norm*ones(1,3));

A=zeros(3*n,9);
%=求解 A*h = 0; 
for idx=1:n
  xL=[m1(idx,:)'];
  xR=[m2(idx,:)'];
  A(3*idx-2:3*idx,:)=[0 0 0 -xR(3)*xL' xR(2)*xL';...
                      xR(3)*xL' 0 0 0 -xR(1)*xL';...
                      -xR(2)*xL' xR(1)*xL' 0 0 0];
end

[U,S,V]=svd(A);  %SVD分解，A=U*S*V',对应于最小特征值的单位特征矢量便是解h
%SVD分解后S为对角矩阵具有正对角元素并沿着对角线按降序排列，那么h是V的最后一列
h=V(:,size(V,2));  % 
H=zeros(3); H(:)=h; H=H';




