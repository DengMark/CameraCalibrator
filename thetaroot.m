function Nroots=thetaroot(r,p,thetamax,thetas)

k2=p(1); k1=p(3); 
n=length(r);
a3=k2*ones(1,n);
a2=zeros(1,n);
a1=k1*ones(1,n);
a0=-r(:)';
tol=10^(-10);

thetam=poly3roots(a3,a2,a1,a0);
ind=( abs(imag(thetam))<tol & thetam>=0 & thetam<thetamax );
check=sum(ind);
if length(find(check~=1))~=0
  disp('In thetaroot: Multiple thetas for a given r');  
  keyboard
end

Nroots=sum(ind,2);
