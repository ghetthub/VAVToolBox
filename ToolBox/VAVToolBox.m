function varargout = VAVToolBox(varargin)
% VAVTOOLBOX MATLAB code for VAVToolBox.fig
%      VAVTOOLBOX, by itself, creates a new VAVTOOLBOX or raises the existing
%      singleton*.
%
%      H = VAVTOOLBOX returns the handle to a new VAVTOOLBOX or the handle to
%      the existing singleton*.
%
%      VAVTOOLBOX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VAVTOOLBOX.M with the given input arguments.
%
%      VAVTOOLBOX('Property','Value',...) creates a new VAVTOOLBOX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VAVToolBox_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VAVToolBox_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VAVToolBox

% Last Modified by GUIDE v2.5 11-Dec-2015 15:30:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @VAVToolBox_OpeningFcn, ...
    'gui_OutputFcn',  @VAVToolBox_OutputFcn, ...
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

%#ok<*DEFNU>

% --- Executes just before VAVToolBox is made visible.
function VAVToolBox_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VAVToolBox (see VARARGIN)

% Choose default command line output for VAVToolBox
handles.output = hObject;

addpath(genpath('./'));
handles = init(hObject, handles);

% Update handles structure
guidata(hObject, handles)


% --- Outputs from this function are returned to the command line.
function varargout = VAVToolBox_OutputFcn(~, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in previous_peak.
function previous_peak_ClickedCallback(hObject, ~, handles)
% hObject    handle to previous_peak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
curFrame = handles.controller.Datas.CurrentFrame();
newFrame = getPeak(handles.divVAV, curFrame, '<');
handles.controller.getFrame(newFrame);

guidata(hObject, handles);


% --- Executes on button press in previous_frame.
function previous_frame_ClickedCallback(hObject, ~, handles)
% hObject    handle to previous_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.controller.getPreviousFrame();

guidata(hObject, handles);


% --------------------------------------------------------------------
function run_OnCallback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
while strcmp(get(handles.run, 'State'), 'on')
    next_frame_ClickedCallback(hObject, eventdata, handles)
end

guidata(hObject, handles);


% --- Executes on button press in next_frame.
function next_frame_ClickedCallback(hObject, ~, handles)
% hObject    handle to next_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.controller.getNextFrame();

guidata(hObject, handles);


% --- Executes on button press in next_peak.
function next_peak_ClickedCallback(hObject, ~, handles)
% hObject    handle to next_peak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
curFrame = handles.controller.Datas.CurrentFrame();
newFrame = getPeak(handles.divVAV, curFrame, '>');
handles.controller.getFrame(newFrame);

guidata(hObject, handles);


% --- Executes on mouse motion over figure - except title and menu.
function main_WindowButtonMotionFcn(hObject, ~, handles)
% hObject    handle to main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mouseLoc = get (handles.top, 'CurrentPoint');
x = mouseLoc(1,1);
y = mouseLoc(1,2);

XLim = handles.top.XLim;
YLim = handles.top.YLim;

time_bar = getappdata(handles.main, 'timeBar');

if x >= XLim(1) && x <= XLim(2) && y >= YLim(1) && y <= YLim(2)
    if isfield(handles, 'mouse_pos')
        set(handles.mouse_pos, 'Xdata', [x x]);
        if isempty(handles.mouse_pos(1).YData)
            set(handles.mouse_pos(1), 'Ydata', time_bar(1).YData);
            set(handles.mouse_pos(2), 'Ydata', time_bar(2).YData);
        end
    else
        handles.mouse_pos(1) = plot(handles.top,    ...
            [x x], time_bar(1).YData, '-k');
        handles.mouse_pos(2) = plot(handles.bottom, ...
            [x x], time_bar(2).YData, '-k');
    end
else
    mouseLoc = get (handles.bottom, 'CurrentPoint');
    x = mouseLoc(1,1);
    y = mouseLoc(1,2);
    
    XLim = handles.bottom.XLim;
    YLim = handles.bottom.YLim;
    
    if x >= XLim(1) && x <= XLim(2) && y >= YLim(1) && y <= YLim(2)
        if isfield(handles, 'mouse_pos')
            set(handles.mouse_pos, 'Xdata', [x x]);
            if isempty(handles.mouse_pos(1).YData)
                set(handles.mouse_pos(1), 'Ydata', time_bar(1).YData);
                set(handles.mouse_pos(2), 'Ydata', time_bar(2).YData);
            end
        else
            handles.mouse_pos(1) = plot(handles.top,    ...
                [x x], time_bar(1).YData, '-k');
            handles.mouse_pos(2) = plot(handles.bottom, ...
                [x x], time_bar(2).YData, '-k');
        end
    elseif isfield(handles, 'mouse_pos')
        reset(handles.mouse_pos);
    end
end

guidata(hObject, handles);


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function main_WindowButtonDownFcn(hObject, ~, handles)
% hObject    handle to main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mouseLoc = get (handles.top, 'CurrentPoint');
x = mouseLoc(1,1);
y = mouseLoc(1,2);

XLim = handles.top.XLim;
YLim = handles.top.YLim;

if x >= XLim(1) && x <= XLim(2) && y >= YLim(1) && y <= YLim(2)
    handles.controller.getFrame(round(x));
    
    guidata(hObject, handles);
end

mouseLoc = get (handles.bottom, 'CurrentPoint');
x = mouseLoc(1,1);
y = mouseLoc(1,2);

XLim = handles.bottom.XLim;
YLim = handles.bottom.YLim;

if x >= XLim(1) && x <= XLim(2) && y >= YLim(1) && y <= YLim(2)
    handles.controller.getFrame(round(x));
    
    guidata(hObject, handles);
end


% --- Executes on key press with focus on main and none of its controls.
function main_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to main (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
switch eventdata.Key
    case 'rightarrow'
        next_frame_ClickedCallback(hObject, eventdata, handles);
    case 'leftarrow'
        previous_frame_ClickedCallback(hObject, eventdata, handles);
    case 'pageup'
        next_peak_ClickedCallback(hObject, eventdata, handles);
    case 'pagedown'
        previous_peak_ClickedCallback(hObject, eventdata, handles);
end


function checked_menu_Callback(hObject, ~, handles)
% hObject    handle to previous_peak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get table handle
if strcmp(hObject.Parent.Tag, 'interMetrics_menu');
    axisHandle = handles.inter;
    enabled = handles.controller.EnabledInter; 
    names = get(handles.interMetrics_menu.Children, 'UserData');
else
    axisHandle = handles.intra;
    enabled = handles.controller.EnabledIntra;
    names = get(handles.intraMetrics_menu.Children, 'UserData');
end

index = find(strcmp(names, hObject.UserData));

% Change checked state
if strcmp(hObject.Checked, 'on')
    set(hObject, 'Checked', 'off');
    lineToMove = logical(strcmp(axisHandle.XTickLabel, hObject.UserData));
    
    axisHandle.XTickLabel(lineToMove) = [];
    enabled(index) = 0;
else
    set(hObject, 'Checked', 'on');
    
    axisHandle.XTickLabel{end+1} = hObject.UserData;
    axisHandle.XTickLabel = sort(axisHandle.XTickLabel);
    
    enabled(index) = 1;
end

axisStep = 1 / (length(axisHandle.XTickLabel) + 1);
newTick = axisStep : axisStep : length(axisHandle.XTickLabel)*axisStep;
axisHandle.XTick = newTick;

% Set new table handle
if strcmp(hObject.Parent.Tag, 'interMetrics_menu');
    handles.inter = axisHandle;
    handles.controller.EnabledInter = enabled;
else
    handles.intra = axisHandle;
    handles.controller.EnabledIntra = enabled;
end


% --------------------------------------------------------------------
function interMetrics_menu_Callback(hObject, eventdata, handles)
% hObject    handle to interMetrics_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function intraMetrics_menu_Callback(hObject, eventdata, handles)
% hObject    handle to intraMetrics_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function graphic_infos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to graphic_infos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% set the tables 'Data' property to a cell array of empty matrices. 
% The size of the cell array determines the number of rows and columns in the table.
set(hObject, 'Data', cell(2,1));
set(hObject, 'RowName', {'Visual', 'AudioVisual'});
set(hObject, 'BackgroundColor', [1 0 0;0 1 0]);


% --- Executes during object creation, after setting all properties.
function metric_infos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to metric_infos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
plotColors = load('plotColors.mat');

set(hObject, 'Data', cell(2,1));
set(hObject, 'RowName', {'Visual', 'AudioVisual'});
set(hObject, 'BackgroundColor', [plotColors.colors(4,:); plotColors.colors(3,:)]);
