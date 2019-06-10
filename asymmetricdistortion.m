function asymmetricdistortion(p,thetamax,s)

% notation different than in the ICPR paper

if length(p)<23;
  p(23)=0;
end

k1=p(1); k2=p(2); mu=p(3); mv=p(4); u0=p(5); v0=p(6);
k3=p(7); k4=p(8); k5=p(9);
i1=p(10); i2=p(11); i3=p(12);
j1=p(13); j2=p(14); j3=p(15); 
l1=p(16); l2=p(17); l3=p(18); l4=p(19);
m1=p(20); m2=p(21); m3=p(22); m4=p(23);
k=[k1 k2 k3 k4 k5];



%fp=fp(:)';
%k1=fp(1); mu=fp(2); mv=fp(3); u0=fp(4); v0=fp(5);
%k2=fp(6); k3=fp(7); k4=fp(8); k5=fp(9);
%k=[k1 k2 k3 k4 k5];
%l=fp(10:12);
%m=fp(13:15);
%i=fp(16:19);
%j=fp(20:23);

%thetamax=pi/2;
thetas=0:thetamax/10:thetamax;
thetas=thetas(1:end-1);
phis=0:2*pi/16:2*pi;
[T,P]=meshgrid(thetas,phis);

tv5=[thetas; thetas.^3; thetas.^5];
tv9=[tv5; thetas.^7; thetas.^9];
rs=k*tv9;
R=ones(length(phis),1)*rs;

%pv=[cos(phis); sin(phis); cos(2*phis); sin(2*phis)];

dr=(j1*T+j2*T.^3+j3*T.^5).*...
   (m1*cos(P)+m2*sin(P)+m3*cos(2*P)+m4*sin(2*P));
dt=(i1*T+i2*T.^3+i3*T.^5).*...
   (l1*cos(P)+l2*sin(P)+l3*cos(2*P)+l4*sin(2*P));

dX=dr.*cos(P)-dt.*sin(P);
dY=dr.*sin(P)+dt.*cos(P);

X=R.*cos(P);
Y=R.*sin(P);

fig=figure;
quiver(X,Y,s*dX,s*dY,0,'k');

hold on

alpha=0:(1/180*pi):2*pi;
%thetamax=pi/2;
rmax=k1*thetamax+k2*thetamax^3+k3*thetamax^5+k4*thetamax^7+k5*thetamax^9;
xcirc=rmax*cos(alpha);
ycirc=rmax*sin(alpha);
plot(xcirc,ycirc,'k-');
plot(0,0,'k+');

axis image
figprop=get(fig);
figaxes=figprop.CurrentAxes;
set(figaxes,'DataAspectRatio',[1 1 1],'XTick',[],'YTick',[]);