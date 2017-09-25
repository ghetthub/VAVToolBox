function updateVideos(values, handles)

[frameV, frameAV] = createFrame(values.video, values.densV, values.densAV);

imshow(values.video,   'Parent', handles.video_orig);
axes(handles.video_orig);
hold on
[Y, X] = find(values.fixV == 1);
plot(X, Y, 'ro');
[Y, X] = find(values.fixAV == 1);
plot(X, Y, 'go');

imshow(frameV,  'Parent', handles.video_v);
imshow(frameAV, 'Parent', handles.video_av);
title(handles.video_av, 'AudioVisual');
title(handles.video_v,  'Visual');

x = handles.controller.Datas.CurrentFrame;
time_bar = getappdata(handles.main, 'timeBar');
set(time_bar, 'Xdata', [x x]);
setappdata(handles.main, 'timeBar', time_bar);
drawnow;

handles.video_infos.Data{4,2} = handles.controller.Datas.CurrentFrame;

end

function [frameV, frameAV] = createFrame(video, densV, densAV)

grayFrame = double(rgb2gray(video));
frameV    = sc(cat(3, mat2gray(double(densV)),  grayFrame),'prob_jet');
frameAV   = sc(cat(3, mat2gray(double(densAV)), grayFrame),'prob_jet');

end