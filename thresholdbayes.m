function th=thresholdbayes(imgvect) 
% th=thresholdbayes(imgvect) 
%
% THRESHOLDBAYES finds the optimal threshold value for a grayscale
% image (256 gray levels) by fitting two normal distributions to
% the histogram
%
% input: 
%   imgvect = the grayscale image as a column vector
%
% output:
%   th = threshold value between 0 and 1

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

index=1:length(imgvect); 
%indo=index; indo(indb)=[]; 
img=double(imgvect);
maxcolor=max(img);
mincolor=min(img);
thval=(maxcolor+mincolor)/2;
thnew=0;
%MITER=100; 
MITER=20; 
 
for i=1:MITER 
    apu=img < thval; 
    indb=find(apu); 
    indo=index; indo(indb)=[]; 
    mub=mean(img(indb)); 
    muo=mean(img(indo)); 
    thnew=1*1/2*(mub+muo); 
    if i>1 & thval==thnew 
        break; 
    end 
    thval=thnew;
end 

pro=length(indo)/length(index);
prb=1-pro;
stdo=std(img(indo));
stdb=std(img(indb));
%[pr,mu,sigma,iter]=em(img,[prb;pro],[mub;muo],[stdb;stdo],2);
[pr,mu,sigma,iter]=emgmm1d(img,[prb;pro],[mub;muo],[stdb;stdo],2);

a=1/2*(1/(sigma(2)^2)-1/(sigma(1)^2));
b=mu(1)/(sigma(1)^2)-mu(2)/(sigma(2)^2);
c=1/2*(mu(2)^2/sigma(2)^2-mu(1)^2/sigma(1)^2)+log(pr(1)/pr(2))+ log(sigma(2)/sigma(1));

th1=(-b-sqrt(b^2-4*a*c))/(2*a);
th2=(-b+sqrt(b^2-4*a*c))/(2*a);
ths=[th1;th2];
n1=norm([th1;th1]-[mu(1); mu(2)]);
n2=norm([th2;th2]-[mu(1); mu(2)]);
[mini,minind]=min([n1 n2]);
thbayes=ths(minind);
th=1/256*thbayes;
