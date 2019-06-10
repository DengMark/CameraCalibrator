function names=processimages(sys)
% PROCESSIMAGES interactive routine for processing calibration images 

% Copyright (C) 2004-2005 Juho Kannala
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

fprintf(1,...
'Locate the calibration plane from the calibration images.\n\n Use left mouse button to click the vertices of a convex polygon that encloses the calibration pattern. \n Indicate the last vertex by the right button.\n Then define a RIGHT HANDED cartesian coordinate system in the calibration plane so that \n when x and y axis are in the plane the positive z axis (orthogonal to the plane) points AWAY from the camera.\n\n');

[idxs,names,datafnames,cfnames]=makefilenames(sys);
blobcolor=sys.blobcolor;  
grayscalew=sys.grayscalew;
N=length(idxs);
i=1;

%counter=1;
while i<N+1
  fprintf(1,' Image %d in progress\n',idxs(i));

  img=imread(names(i,:));
  if length(size(img))>2
    img=rgb2gray(img);
  end
  
  [cartcoord,bimg,winr,gridsize,fighandle]=calibboard(img);
  close(fighandle);
  
  fighandle=planevis(img,bimg,cartcoord); 
  
  ip=input('  Satisfied? (n=no, other=yes): ','s');
  
  if isempty(ip) 
    save(datafnames(i,:),'cartcoord','bimg','winr','gridsize'); 
    %i=i+1;
  elseif strcmp(ip,'n')
    disp('Process the previous image again');
    close(fighandle);
    continue;
  else
    save(datafnames(i,:),'cartcoord','bimg','winr','gridsize'); 
    %i=i+1;
  end
  %close(fighandle);
  
  %%%%%%%%%%%%% from controlpoints.m %%%%%%%%%%%%%
  
  [blobs,th]=findblobs(img, bimg, winr,blobcolor);
 
  if sys.gui
    fprintf(1,'Adjust the grayscale threshold if necessary.\n Click OK when finished.\n');
    [blobs,th_final]=calibgui(th,img,bimg,blobs,winr,blobcolor,fighandle);
    %fig0=blobvis(img,blobs,[]);
    %keyboard
    %[blobs,th]=findblobs(img,bimg,winr,blobcolor,th_final);
  else
    th_final=th;
  end
  display('Wait ...');
  %[blobs,th]=findblobs(img,bimg,winr,blobcolor,th_final);
  %blobvis_update(handles.img,handles.blobs,handles.bimg,handles.fighandle);
  
  [ydim,xdim]=size(img);
  %figure; imshow(blobs);
  %figa=blobvis(img,blobs,[]);
  %keyboard
  [SUCCESS, cmat, blobs]=arrangeblobs(blobs, gridsize,cartcoord);
  %figb=blobvis(img,blobs,cmat);
  %keyboard
  if ~SUCCESS
    fprintf('   In controlpoints: Can not find all blobs from image %d.\n',idxs(i)); 
    %figure; imshow(blobs);
    %keyboard
    %cm{counter}=[];
    %counter=counter+1;
    close(fighandle);
    continue;
  end
  %fig2=figure;
  %blobvis_update(img,blobs,bimg,2);
  if strcmp(grayscalew,'gray')
    display('Computing grayscale centroids ...');
    cmatold=cmat;
    [cmat,blobs]=blobsgrayscale(img,blobs,cmat,blobcolor);
    %figure; imshow(blobs);
    xdiff=cmat(:,:,1)-cmatold(:,:,1);
    ydiff=cmat(:,:,2)-cmatold(:,:,2);
    totdiff=sqrt(xdiff.^2+ydiff.^2);
    mdiff=mean(mean(totdiff));
  end

  save(cfnames(i,:),'cmat');
  close(fighandle);
  fighandle=blobvis(img,blobs,cmat);
  %figc=blobvis(img,blobs,cmat);
  %keyboard
  %counter=counter+1;

  ip=input('  Satisfied? (n=no, other=yes): ','s');
  if isempty(ip) 
    %save(datafnames(i,:),'cartcoord','bimg','winr','gridsize'); 
    i=i+1;
  elseif strcmp(ip,'n')
    disp('Process the previous image again');
    close(fighandle);
    continue;
  else
    %save(datafnames(i,:),'cartcoord','bimg','winr','gridsize'); 
    i=i+1;
  end
  %disp('  Press any key to proceed to the next image');
  %pause

  close(fighandle);
  
  %%%%%%%%%%%%%%%%%%%%
end
