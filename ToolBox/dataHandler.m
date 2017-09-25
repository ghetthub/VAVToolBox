function dataHandler(~, eventdata, handles)
% VIDEOHANDLER Handle used to add a listener for different video related
% events.

if ~isempty(eventdata.Data)
    updateGraphics(eventdata.Metric.Values, handles);
    updateInfos(eventdata.Data.Values, handles);
    initMetrics(handles);
end

end