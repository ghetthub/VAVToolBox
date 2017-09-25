function handles = updateInfos(datas, handles)

handles.video_infos.Data(:,2) = {datas.name, datas.category, datas.nb_frame, 0};

end