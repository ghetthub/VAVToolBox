function updateMetrics(values, handles)

set(handles.hybrid.Children(1), 'YData' ,values.hybrid(:,1));
set(handles.hybrid.Children(2), 'YData' ,values.hybrid(:,2));
set(handles.density.Children,   'YData' ,values.density);
set(handles.fixation.Children,  'YData' ,values.fixation);

end