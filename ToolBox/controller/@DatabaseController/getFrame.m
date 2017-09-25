function getFrame(obj, nbr)

obj.Datas.CurrentFrame = nbr;
obj.readFrames();

if obj.Datas.CurrentFrame <2
    notify(obj, 'FrameRead', FrameRead('Status', 'Start'));
elseif ~obj.Datas.Stimuli.hasFrame()
    notify(obj, 'FrameRead', FrameRead('Status', 'End'));
end

end