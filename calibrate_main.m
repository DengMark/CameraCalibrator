function varargout = calibrate_main(varargin)
% CALIBRATE_MAIN MATLAB code for calibrate_main.fig
%      CALIBRATE_MAIN, by itself, creates a new CALIBRATE_MAIN or raises the existing
%      singleton*.
%
%      H = CALIBRATE_MAIN returns the handle to a new CALIBRATE_MAIN or the handle to
%      the existing singleton*.
%
%      CALIBRATE_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALIBRATE_MAIN.M with the given input arguments.
%
%      CALIBRATE_MAIN('Property','Value',...) creates a new CALIBRATE_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before calibrate_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to calibrate_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help calibrate_main

% Last Modified by GUIDE v2.5 13-May-2019 16:31:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @calibrate_main_OpeningFcn, ...
                   'gui_OutputFcn',  @calibrate_main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before calibrate_main is made visible.
function calibrate_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to calibrate_main (see VARARGIN)

% Choose default command line output for calibrate_main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes calibrate_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = calibrate_main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function focal_Callback(hObject, eventdata, handles)
% hObject    handle to focal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of focal as text
%        str2double(get(hObject,'String')) returns contents of focal as a double
%  handles.focal=str2double(get(hObject,'String'));
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function focal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to focal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fov_Callback(hObject, eventdata, handles)
% hObject    handle to fov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fov as text
%        str2double(get(hObject,'String')) returns contents of fov as a double
%  handles.viewfield=str2double(get(hObject,'String'));
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function fov_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dx_Callback(hObject, eventdata, handles)
% hObject    handle to dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dx as text
%        str2double(get(hObject,'String')) returns contents of dx as a double
% handles.mu=1.0/str2double(get(hObject,'String'));
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function dx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dy_Callback(hObject, eventdata, handles)
% hObject    handle to dy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dy as text
%        str2double(get(hObject,'String')) returns contents of dy as a double
% handles.mv=1.0/str2double(get(hObject,'String'));
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function dy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function u0_Callback(hObject, eventdata, handles)
% hObject    handle to u0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of u0 as text
%        str2double(get(hObject,'String')) returns contents of u0 as a double
% handles.u0=str2double(get(hObject,'String'));
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function u0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to u0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v0_Callback(hObject, eventdata, handles)
% hObject    handle to v0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v0 as text
%        str2double(get(hObject,'String')) returns contents of v0 as a double
% handles.v0=str2double(get(hObject,'String'));
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function v0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in model.
function model_Callback(hObject, eventdata, handles)
% hObject    handle to model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns model contents as cell array
%        contents{get(hObject,'Value')} returns selected item from model
% contents = cellstr(get(hObject,'String'));
%  handles.model=contents{get(hObject,'Value')};
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function model_CreateFcn(hObject, eventdata, handles)
% hObject    handle to model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in projtype.
function projtype_Callback(hObject, eventdata, handles)
% hObject    handle to projtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns projtype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from projtype
%  contents = cellstr(get(hObject,'String'));
%  handles.projtype=contents{get(hObject,'Value')};
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function projtype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to projtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ImagePath.
function ImagePath_Callback(hObject, eventdata, handles)
% hObject    handle to ImagePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[image_name, file_path]=uigetfile('*.*','Select the image files', 'MultiSelect', 'on');
num_img = length(image_name);
set(handles.image_path,'String',file_path);
set(handles.image_num,'String', num_img);
global image_index
global imagePoints worldPoints
image_index = cell(num_img,3);
 allimage=cast([], 'uint8');
 a="";
for i=1:num_img
    name = image_name{1,i};
    im = imread(strcat(file_path,name));
   allimage(:, :, :, i) = im;
    image_index{i,1}=i;
    image_index{i,2}=name;
    image_index{i,3}=cast(im,'uint8');
    a(i)='Image #'+string(i);
end
%handles.imagedata = allimage;
set(handles.image_listbox,'String',a);

%images = handles.imagedata;
squareSize =str2double(handles.squareSize.String); % millimeters
% Try to detect the checkerboard
 [imagePoints, boardSize] = detectCheckerboardPoints(allimage);
%[imagePoints, boardSize] = detectCheckerboardPoints(image_index{:,3});
% Generate world coordinates of the checkerboard points.
worldPoints = generateCheckerboardPoints(boardSize, squareSize);
cameraParams = estimateCameraParameters(imagePoints,worldPoints);
global principalPoint f_dxdy
principalPoint=cameraParams.PrincipalPoint;
f_dxdy =cameraParams.FocalLength ;
 guidata(hObject, handles);
 
function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double



% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function squareSize_Callback(hObject, eventdata, handles)
% hObject    handle to squareSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of squareSize as text
%        str2double(get(hObject,'String')) returns contents of squareSize as a double
% handles.squareSize= str2double(get(hObject,'String'));
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function squareSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to squareSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double



% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% % --- Executes during object creation, after setting all properties.
% function text12_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to image_path (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% set(hObject,'String',hangles.file_path);
% disp(hangles.file_path);
%  guidata(hObject, handles);


% --- Executes on button press in main.
function main_Callback(hObject, eventdata, handles)
% GUI main Function
% hObject    handle to main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global f
global sys
global imagePoints worldPoints
global p Rs ts err
 f = waitbar(0,'Please wait...');
 pause(0.5)

  sys.gui=0;
  sys.nameprefix='';   
  sys.namesuffix='';
  sys.numlen=0;
  sys.indexes=[];
  sys.minidx=0;
  sys.maxidx=0;
  sys.blobcolor='white'; 
  sys.blobgapx=0;
  sys.blobgapy=0;
  sys.grayscalew='binary';  
  sys.circularimage='no';
  sys.cata=0;
  sys.blobradius=0;  
  contents_projtype = cellstr(get(handles.projtype,'String'));  % perspective, stereographic, 
  sys.projtype=contents_projtype{get(handles.projtype,'Value')};       % equidistance, equisolidangle,
  contents_model = cellstr(get(handles.model,'String'));  % basic, radial or extended
  sys.model=contents_model{get(handles.model,'Value')}; 
  sys.focal=str2double(handles.focal.String);    % nominal focal length in millimeters
  sys.viewfield=str2double(handles.fov.String);  % 2*\theta_{max} in degrees
  mu=1.0/str2double(handles.dx.String);
  mv=1.0/str2double(handles.dy.String);
  u0=str2double(handles.u0.String);
  v0=str2double(handles.v0.String);
  sys.pixelp=[mu mv u0 v0]; % values for the parameters m_u m_v u_0 v_0 
                            % leave empty if sys.circularimage='yes' 
waitbar(.1,f,'Loading the image data...');
pause(1)
N_imagePoints = size(imagePoints,3);
%ms = cell(N_imagePoints);

for i=1:N_imagePoints
    ms{i}=imagePoints(:,:,i);
    xs{i}=worldPoints;
end

waitbar(.2,f,'Processing the image data...');
pause(1)
[p,Rs,ts,err]=calibrate_dh(sys,ms, xs);  

disp(p');
disp('Calibration successfully!')
set(handles.p,'String',strtrim(cellstr(num2str(p'))'));
waitbar(1,f,'Calibration successfully!');
pause(1)
close(f)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function image_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to image_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in export_p.
function export_p_Callback(hObject, eventdata, handles)
% hObject    handle to export_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p p0
global sys mres
global meanerr rmserr su sv thetamax_first thetamax maxd meand
% fid = fopen('.\data\p.txt','wt');
  fid = fopen('p.txt','wt');
 p_num =9;
if strcmp(sys.model,'basic')
     p_num=6;
end
if strcmp(sys.model,'extended')
     p_num=23;
end
fprintf(fid,'Some important log/camera calibration data:\n');
fprintf(fid,'Average residual for fitting projecttype of %s model: %g\n',sys.projtype,mres);
fprintf(fid,'p0:\n');
fprintf(fid,'%6.2f\t',p0);
fprintf(fid,'\n');
% fprintf(fid,'Rs0:\n');
% fprintf(fid,'%8.4f %8.3f %6.2f\n',Rs0{:});
% fprintf(fid,'ts0:\n');
% fprintf(fid,'%6.2f\n',ts0{:});

fprintf(fid,'Mean distance between measured and modelled centroids before nonlinear minimization: %.4f pixels\n',meanerr);
fprintf(fid,'RMS distance between measured and modelled centroids: %.4f pixels\n',rmserr);
fprintf(fid,'Standard deviation of the residuals:\n');
fprintf(fid,'  sigma_u: %.4f pixels\n',su);
fprintf(fid,'  sigma_v: %.4f pixels\n',sv);
fprintf(fid,'Radial projection curve is increasing up to %f degrees.\n',thetamax_first/pi*180);
fprintf(fid,'The initial value for thetamax given in calibconfig.m was %f degrees,\n',thetamax/pi*180);
fprintf(fid,'The backward model error:\n');
fprintf(fid,'  maximum reprojection error: %e pixels\n',maxd);
fprintf(fid,'  mean reprojection error: %e pixels\n\n',meand);

for ii=1:p_num
fprintf(fid,'para%d=%g#\n',ii,p(ii));
end
fclose(fid);
msgbox('Export Camera parameters successfully!')  
guidata(hObject, handles);
%disp('Export Camera parameters successfully!')


% --- Executes on button press in error_show.
function error_show_Callback(hObject, eventdata, handles)
% hObject    handle to error_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global err meanerr
n_error=length(err);
error_p=zeros(n_error,1);
for i=1:n_error
    error_p(i)=mean(err{1,i});
end
axes(handles.projerr_graph);
bar(handles.projerr_graph,error_p,'c');
hold on
xlim=get(gca,'Xlim');
plot(xlim,[meanerr meanerr],'r--');
title('Reprojection Errors')
xlabel('Images Index')
ylabel('Mean Error Pixels')
guidata(hObject, handles);


% --- Executes on selection change in image_listbox.
function image_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to image_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns image_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from image_listbox
contents = cellstr(get(hObject,'String'));
list_name = contents{get(hObject,'Value')};
list_n = str2double(handles.image_num.String);
axes(handles.image_show);
global image_index imagePoints
for i=1:list_n
if strcmp(list_name,'Image #'+string(i))
  %  fprintf('Choose image # %d\n',i);
    imshow(image_index{i,3}) 
    hold on
    plot(imagePoints(:,1,i),imagePoints(:,2,i),'ro');
    hold on
    plot(imagePoints(1,1,i),imagePoints(1,2,i),'s',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b');
    hold on
    line([imagePoints(1,1,i) imagePoints(34,1,i)],[imagePoints(1,2,i) imagePoints(34,2,i)],...
        'Color','yellow','LineWidth',3);
    hold on
    line([imagePoints(1,1,i) imagePoints(3,1,i)],[imagePoints(1,2,i) imagePoints(3,2,i)],...
        'Color','green','LineWidth',3);
    title(image_index{i,2})
end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function image_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to image_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function image_show_CreateFcn(hObject, eventdata, handles)
% hObject    handle to image_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate image_show
set(hObject,'xTick',[]);
set(hObject,'ytick',[]);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
