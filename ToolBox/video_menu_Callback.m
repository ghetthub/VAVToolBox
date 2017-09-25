function video_menu_Callback(hObject, ~, handles)
% hObject    handle to previous_peak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

nbr = hObject.UserData;

% Get the data
handles.controller.getData(nbr);

handles.time_bar = [line, line];

% Update handles structure
guidata(hObject, handles)

% Plot first frame
handles.controller.getNextFrame();

guidata(hObject, handles);

end