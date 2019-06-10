function varargout = calibgui(varargin)
% CALIBGUI M-file for calibgui.fig
%      CALIBGUI, by itself, creates a new CALIBGUI or raises the existing
%      singleton*.
%
%      H = CALIBGUI returns the handle to a new CALIBGUI or the handle to
%      the existing singleton*.
%
%      CALIBGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALIBGUI.M with the given input arguments.
%
%      CALIBGUI('Property','Value',...) creates a new CALIBGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before calibgui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to calibgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help calibgui

% Last Modified by GUIDE v2.5 28-Dec-2005 19:50:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @calibgui_OpeningFcn, ...
                   'gui_OutputFcn',  @calibgui_OutputFcn, ...
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


% --- Executes just before calibgui is made visible.
function calibgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to calibgui (see VARARGIN)

handles.th=varargin{1};
handles.img=varargin{2};
handles.bimg=varargin{3};
handles.blobs=varargin{4};
handles.winr=varargin{5};
handles.blobcolor=varargin{6};
handles.fighandle=varargin{7};

% Choose default command line output for calibgui
%handles.output =handles.th;
set(handles.slider1,'Value',handles.th);
set(handles.edit2,'String',num2str(handles.th));

blobvis_update(handles.img,handles.blobs,handles.bimg,handles.fighandle);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes calibgui wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = calibgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Get default command line output from handles structure
%varargout(1) = handles.output;
%display('before uiresume');
%uiresume(handles.figure1);
%display('after uiresume');
varargout{1} = handles.blobs;
varargout{2} = handles.th;
delete(handles.figure1);

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


val=get(handles.slider1,'Value');
set(handles.edit2,'String',num2str(val));
handles.th=val;
[blobs,th]=findblobs(handles.img, handles.bimg, handles.winr, ...
		     handles.blobcolor, val);
handles.blobs=blobs;
guidata(hObject,handles);

blobvis_update(handles.img,handles.blobs,handles.bimg,handles.fighandle);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

val = str2double(get(handles.edit2,'String'));
% Determine whether val is a number between 0 and 1
if isnumeric(val) & length(val)==1 & ...
    val >= get(handles.slider1,'Min') & ...
    val <= get(handles.slider1,'Max')
    set(handles.slider1,'Value',val);
else
% Increment the error count, and display it
    %handles.number_errors = handles.number_errors+1;
    %guidata(hObject,handles); % store the changes
    set(handles.edit2,'String','invalid entry');
end
handles.th=val;
[blobs,th]=findblobs(handles.img, handles.bimg, handles.winr, ...
		     handles.blobcolor, val);
handles.blobs=blobs;
guidata(hObject,handles);

blobvis_update(handles.img,handles.blobs,handles.bimg,handles.fighandle);



% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume(handles.figure1)
%delete(handles.figure1);
