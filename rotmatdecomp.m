function [w,ntheta,nphi]=rotmatdecomp(R)
% [w,ntheta,nphi]=rotmatdecomp(R)
%
% ROTMATDECOMP decomposes a rotation matrix 
%
% input:
%   R = orthogonal 3*3-matrix so that det(R)=+1
%
% output:
%   w = the rotation angle in radians
%   ntheta = the angle between rotation axis and z-axis
%   nphi = the angle between x-axis and the projection of the
%          rotation axis to the xy-plane
%

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

[V,D]=eig(R);
d=diag(D);
eigval=d;
eigdif=abs(eigval-ones(3,1));
[s,ind]=sort(eigdif);
n=V(:,ind(1));
absw=abs(angle(d(ind(2))));
Z=null(n');
z1=Z(:,1);
z1rot=R*z1;

v=cross(z1,z1rot)/(norm(z1)*norm(z1rot));
w=sign(n'*v)*absw;

ntheta=acos(n(3));
sector=n(1)<=0;
nphi=atan(n(2)./n(1));
nphipluspi=nphi+pi;
nphi=sector.*nphipluspi+(~sector).*nphi;

