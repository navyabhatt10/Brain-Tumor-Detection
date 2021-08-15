function varargout = tumor_gui(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tumor_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @tumor_gui_OutputFcn, ...
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
% End initialization code 


function tumor_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args
% hObject    handle to figure
% eventdata  reserved 
% handles    structure with handles and user data 
% varargin   command line arguments to tumor_gui 

% Choose default command line output 
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tumor_gui wait for user response 
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tumor_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args;

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)

global im im2
[path,user_cancel]=imgetfile();
if user_cancel
    msgbox(sprintf('Invalid Selection'),'Error','Warn');
    return
end

im=imread(path);
im=im2double(im);
im2=im;
axes(handles.axes1);
imshow(im)
title('Patient''s Brain MRI Image')


% --- Executes on button press in detect.
function detect_Callback(hObject, eventdata, handles)

global im 

axes(handles.axes2);

bw=im2bw(im,0.7);
label=bwlabel(bw);

stats=regionprops(label,'Solidity','Area');
density=[stats.Solidity];
area=[stats.Area];
high_dense_area=density>0.5;
max_area=max(area(high_dense_area));
tumor_label=find(area==max_area);
tumor=ismember(label,tumor_label);

se=strel('square',5);
tumor=imdilate(tumor,se);
B=bwboundaries(tumor,'noholes');
imshow(im);

hold on
for i=1:length(B)
    plot(B{i}(:,2),B{i}(:,1), 'y' ,'linewidth',1.75);
    
end

title('Detected Tumor');
hold off;
    

% --------------------------------------------------------------------
function details_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function name_Callback(hObject, eventdata, handles)

msgbox(sprintf('NAME: NAVYA BHATT'))

% --------------------------------------------------------------------
function rollno_Callback(hObject, eventdata, handles)

msgbox(sprintf('ROLL NUMBER: 2013396'))
% --------------------------------------------------------------------
function sec_Callback(hObject, eventdata, handles)

msgbox(sprintf('SECTION: A'))

% --------------------------------------------------------------------
