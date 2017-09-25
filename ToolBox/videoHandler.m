function videoHandler(~, eventdata, handles)
% VIDEOHANDLER Handle used to add a listener for different video related
% events.

switch(eventdata.EventName)
    case('FrameRead')
        switch(eventdata.Status)
            case('Start')
                % First frame => previous buttons disabled
                set(handles.previous_frame, 'Enable', 'off');
                set(handles.previous_peak,  'Enable', 'off');
                
            case('End')
                % NoMoreFrame frame => next buttons disabled
                %                      Play/pause   disabled
                set(handles.next_frame, 'Enable', 'off');
                set(handles.next_peak,  'Enable', 'off');
                set(handles.run, 'State', 'off')
                
            case('Ok')
                % Normal => next/previous buttons enabled if not playing (run
                %           button in "pause" mode)
                if strcmp(get(handles.run, 'State'), 'off')
                    set(handles.previous_frame, 'Enable', 'on');
                    set(handles.previous_peak,  'Enable', 'on');
                    set(handles.next_frame,     'Enable', 'on');
                    set(handles.next_peak,      'Enable', 'on');
                end
        end
        
        if ~isempty(eventdata.Data)
            updateVideos(eventdata.Data.Values, handles);
            updateMetrics(eventdata.Metric.Values, handles);
        end
    case('PostSet')
        % PostSet => next/previous button enabled
        set(handles.previous_frame, 'Enable', 'on');
        set(handles.previous_peak,  'Enable', 'on');
        set(handles.next_frame,     'Enable', 'on');
        set(handles.next_peak,      'Enable', 'on');
        
    case('PreSet')
        % PreSet => next/previous button disabled
        set(handles.previous_frame, 'Enable', 'off');
        set(handles.previous_peak,  'Enable', 'off');
        set(handles.next_frame,     'Enable', 'off');
        set(handles.next_peak,      'Enable', 'off');
end

end