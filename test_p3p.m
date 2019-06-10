
clc
clear all
close all

max_angle=78;
Ustar=379;
Vstar=240;
%**************************************************************************
%世界坐标表示的空间点分布(X,Y,Z) mm

k1=1;       p1=1;         u1=1;
R1=[cos(k1)*cos(p1)    cos(p1)*sin(k1)*sin(u1)-sin(p1)*cos(u1)    cos(p1)*sin(k1)*cos(u1)+sin(p1)*sin(u1);
    sin(p1)*cos(k1)    sin(p1)*sin(k1)*sin(u1)+cos(p1)*cos(u1)    sin(p1)*sin(k1)*cos(u1)-cos(p1)*sin(u1);
    -sin(k1)           cos(k1)*sin(u1)                             cos(k1)*cos(u1)        ];
t1=[-222.17054   491.61100  3207.62041]/1000;
2.20682    -0.34330     0.14623  
N=4;
Xcam=zeros(3,N);
for i=1:N,
    xaax=rand()*(200+200)-200;
    xaay=rand()*(100+200)-200;
    xaaz=rand()*(2000-1500)+1500;
    xaa=[xaax;xaay;xaaz]/1000;
    Xobj(:,i)=xaa;  
    Xcam(:,i)=R1*xaa+t1;
end

%图像上点的坐标叠加标准差为q的零均值高斯噪声——（真实图像点）
y1=randn(2,3*N);
ap1=0;
bp1=0;   %噪声等级
y1=ap1+bp1*y1;%%%%%%%%%%%%%%%%%%
for i=1:N,
    Xa1z(:,i)=Xa1(:,i)+y1(:,i);
end



