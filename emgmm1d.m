function [pr,mu,sigma,iter]=emgmm1d(x,pr,mu,sigma,N)
% EMGMM1D EM-algorithm for one dimensional gaussian mixture models
%

% Copyright (C) 2005 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

%display('emgmm1d');
CONVERGENCE_TOL=0.01; 
VAR_MINI=0.0005;
%ITER_MAXI=100; 
ITER_MAXI=25; 
  
M=length(x);

if N==1
  pr=1;
  mu=mean(x);
  sigma=std(x);
  iter=1;
else
  X=x(:,ones(1,N)); var=sigma.^2; iter=0; converged=0;
  mu=mu(:)'; var=var(:)'; pr=pr(:)';
  while (~converged & iter<ITER_MAXI)
    iter=iter+1;
    po=post(x,pr,mu,sqrt(var));    
    mu_new=sum(po.*X)./sum(po); Mus=mu_new(ones(length(x),1),:);
    var_new=sum(po.*(X-Mus).^2)./sum(po); 
    pr_new=mean(po); 
    if var_new > VAR_MINI;
      converged=((norm(pr_new-pr)+norm(var_new-var)+norm(mu_new-mu))<CONVERGENCE_TOL);
    end
    pr=pr_new;
    var=var_new; 
    mu=mu_new;    
  end
  sigma=sqrt(var);
  if iter==ITER_MAXI
    disp('In emgmm1d: Warning, EM-algorithm did not converge');
  end
end

function postprobs=post(x,pr,mu,sigma)

pxpercls=zeros(length(x),length(pr));
for idx=1:length(pr);
  pxpercls(:,idx)=pr(idx)*1/(sigma(idx))*exp(-0.5/((sigma(idx))^2)*(x(:)-mu(idx)).^2);
end
tot=sum(pxpercls,2);
tot=tot(:,ones(1,length(pr)));
postprobs=pxpercls./tot;
