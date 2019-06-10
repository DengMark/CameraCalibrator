function findellipse(names)
% FINDELLIPSE searches the ellipse that bounds the image produced
% by a circular image fish-eye lens. All calibration images are
% used and the parameters of the ellipse are computed as an average.
% User may discard wrongly positioned ellipses. 
%

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

N=size(names,1);
pars=[];

disp('Searching the ellipse that bounds the image ...');

for i=1:N
  fprintf(1,' Image %d in progress\n',i);
  img=imread(names(i,:));
  if length(size(img))>2
    img=rgb2gray(img);
  end
  p=imgellipse(img);
  a=p(1); b=p(2); x0=p(3); y0=p(4);
  
  t=0:0.5:359.5; t=2*pi/360*t;
  ellipsex=x0+a*cos(t); ellipsey=y0+b*sin(t);
  figi=figure; axis image; imshow(img); hold on
  plot(x0,y0,'r+');
  plot(ellipsex,ellipsey,'m-');
  
  ip=input('  Satisfied with the ellipse? (n=no, other=yes): ','s');
  
  if strcmp(ip,'n')
  else
    pars=[pars; p];
  end
  
  close(figi);
end

if isempty(pars)
  disp('In findellipse: The ellipse detection did not succeed. You must give the parameters in sys.pixelp manually. See calibconfig.m.');
  ep=[];
elseif size(pars,1)==1
  ep=pars;
else
  ep=mean(pars);
end
pars=pars
ep=ep
save ep ep;
