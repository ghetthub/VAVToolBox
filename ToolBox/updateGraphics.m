function handles = updateGraphics(metrics, handles)

dispersion = metrics.disp;
dispV      = dispersion(1).score;
dispAV     = dispersion(2).score;
dispVAV    = abs(dispV - dispAV);

YTop    = max(max(dispVAV)) + 10;
YBottom = max(max(dispV), max(dispAV)) + 10;

if isempty(handles.top.Children)
    
    % No Children mean first call to this function
    set(handles.timeGraphs.Children, 'Visible', 'on');
    axis(handles.top, [0 size(dispAV,2) -10 YTop]);
    title(handles.top, 'Absolute difference');
    
    axis(handles.bottom, [0 size(dispAV,2) -10 YBottom]);
    title(handles.bottom, 'Visual & AudioVisual');
    
    handles.video_infos.Data(:,1) = {'Video', 'Category', ...
        'Number of Frames', 'Current Frame'};
    handles.video_infos.Data(:,2) = {'clip_1', 'moving objects', ...
        size(dispAV,2), 0};
else
    cla(handles.top);
    cla(handles.bottom);
    
    set(handles.top, 'XLim', [0 size(dispAV,2)], ...
        'YLim', [-10 YTop]);
    set(handles.bottom, 'XLim', [0 size(dispAV,2)], ...
        'YLim', [-10 YBottom]);
end

plot(handles.top, dispVAV,'b');
timeT = plot(handles.top, [0 0],[-10 YTop],'-r');

plot(handles.bottom, dispV, 'r');
plot(handles.bottom, dispAV,'g');
timeB = plot(handles.bottom, [0 0], [-10 YBottom], '-r');

setappdata(handles.main, 'timeBar', [timeT timeB]);

end