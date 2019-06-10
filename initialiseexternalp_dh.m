function [Rs,ts]=initialiseexternalp_dh(Hs,K,side)
% [Rs,ts]=initialiseexternalp(Hs)
%
% INITIALISEEXTERNALP extracts the initial values for the rotations
% and translations from the homographies computed by UPDATEHOMOGRAPHIES
% 
% input:
%   Hs = cell array, Hs{j} is the homography for view j
% optional:
%   K = upper triangular matrix so that H=K[r1 r2 t],
%       default K=eye(3)
%
% output:
%   Rs = cell array, Rs{j} is the rotation matrix for view j
%   ts = cell array, ts{j} is the translation vector for view j
%

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

N=length(Hs);
if nargin<2 | isempty(K)
  invK=eye(3);
else
  invK=inv(K);
end

for i=1:N
  Rt=invK*Hs{i};
  Rt=1/(1/2*(norm(Rt(:,1))+norm(Rt(:,2))))*Rt;
  %if Rt(3,3)<0
  %  Rt=-Rt;
  %end
  r1=Rt(:,1);
  r2=Rt(:,2);
  r3=cross(r1,r2);
  
  Ra=[r1 r2 r3];ta=Rt(:,3);
  Rb=[-r1 -r2 r3];tb=-ta;
  Ca=-Ra'*ta;
  if side
    sidesign=-1;
  else
    sidesign=1;
  end
  if (sidesign*Ca(3))<0
  %if Ca(3)>0
    Q=Ra;t=ta;
  else
    Q=Rb;t=tb;
  end 
  
  %t=Rt(:,3);
  %Q=[r1 r2 r3];
  
  [U,S,V]=svd(Q);
  R=U*V';
  Rs{i}=R;
  ts{i}=t;
end
