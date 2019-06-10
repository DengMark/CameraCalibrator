function [idxs, names, datafnames, cfnames]=makefilenames(sys)
% [names,datafnames,cfnames,idxs]=makefilenames(name,suffix,numlen,indexes,minidx,maxidx)
%
% MAKEFILENAMES forms the names of the input and output files into
% character arrays
%
% input:
%   name = the name prefix 
%   suffix = the suffix of the file format
%   numlen = the number of digits in the calibration image index
%   indexes = vector containing the image indexes, leave this empty
%             if the indexes are given by minidx and maxidx
%   minidx = the smallest index of the images
%   maxidx = the greatest index of the images
%
% output:
%   idxs = either idxs=indexes or idxs=minidx:maxidx
%   names = character array whose rows contain the calibration
%           image names
%   datafnames = character array, rows of the form ['calibdataXXX.mat']
%   cfnames = character array, rows of the form ['cmXXX.mat']
%

% Copyright (C) 2004 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

indexes=sys.indexes;
name=sys.nameprefix;
suffix=sys.namesuffix;
numlen=sys.numlen;
minidx=sys.minidx;
maxidx=sys.maxidx;
grayw=sys.grayscalew;

Nslots=numlen;
if ~isempty(indexes)
  idxs=indexes;
else
  idxs=minidx:maxidx;
end


N=length(idxs);

for i=1:N
  num=sprintf(['%.' num2str(Nslots) 'd'],idxs(i));
  filename=strcat(name,num,'.',suffix);
  outputfile=strcat('calibdata',num,'.mat');
  if strcmp(grayw,'gray')
    cfile=strcat('cmg',num,'.mat');
  else
    cfile=strcat('cm',num,'.mat');
  end
  names(i,:)=filename;
  datafnames(i,:)=outputfile;
  cfnames(i,:)=cfile;
end
