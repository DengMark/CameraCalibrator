function x=generic2sphere_dh(m,p,thetamax)


pc=p(1:min(9,length(p)));

%[theta,phi]=backprojectgeneric(m,p,thetamax);
[theta,phi]=backproject_dh(m,pc,thetamax);

x=[cos(phi).*sin(theta) sin(phi).*sin(theta) cos(theta)];

