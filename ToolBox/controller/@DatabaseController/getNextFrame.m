function getNextFrame(obj)

if obj.Datas.Stimuli.hasFrame()
    obj.readFrames();
    
    if ~obj.Datas.Stimuli.hasFrame()
        notify(obj, 'FrameRead', FrameRead('Status', 'End'));
    end
else
    notify(obj, 'FrameRead', FrameRead('Status', 'End'));
end

end