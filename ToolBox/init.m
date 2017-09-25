function handles = init(hObject, handles)

% Get controller
handles.controller = DatabaseController();

% Edit video menu
handles = initMenus(handles);

% Add listeners
handles = initListeners(handles);

% Read first data
handles.controller.getData();

% Update handles structure
guidata(hObject, handles)

end

% -- Initialize database linked menus.
function handles = initMenus(handles)

menuStruct = handles.controller.getMenuArch();
categories = fieldnames(menuStruct);

% One menu per category (objects, landscapes, faces, ...)
for i = 1 : length(categories)
    fName = categories{i};
    subHandle = uimenu(handles.videoSelect_menu, 'Label', fName);
    
    % One submenu per video (in the category)
    for j = menuStruct.(fName)
        vName = ['clip_', num2str(j)];
        uimenu(subHandle, 'Label', vName, ...
            'UserData', j, ...
            'Callback', @(hObject, eventdata) video_menu_Callback(hObject, eventdata, handles));
    end
end

end

% -- Initialize listeners to different actions in the GUI.
function handles = initListeners(handles)

% Add listener to video playing, such as:
%   - End   is triggered when the video read as no more frames.
%   - Start is triggered when the video read is at the first frame.
%   - Ok    is triggered the rest of the time while reading.
addlistener(handles.controller, 'FrameRead', ...
    @(hObject, eventdata) videoHandler(hObject, eventdata, handles));
addlistener(handles.controller, 'DataRead',  ...
    @(hObject, eventdata) dataHandler(hObject, eventdata, handles));


% Add listener to run button state, such as:
%   - PostSet is triggered before playing (before play)
%   - PreSet  is triggered after  playing (before pause)
addlistener(handles.run, 'State', 'PostSet', ...
    @(hObject, eventdata) videoHandler(hObject, eventdata, handles));
addlistener(handles.run, 'State', 'PreSet',  ...
    @(hObject, eventdata) videoHandler(hObject, eventdata, handles));
end