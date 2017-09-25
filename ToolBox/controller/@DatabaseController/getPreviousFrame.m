function getPreviousFrame(obj)

if obj.Datas.CurrentFrame > 1
    obj.Datas.CurrentFrame = obj.Datas.CurrentFrame - 2;
    obj.readFrames();
    
    if obj.Datas.CurrentFrame < 2
        notify(obj, 'FrameRead', FrameRead('Status', 'Start'));
    end
else
    notify(obj, 'FrameRead', FrameRead('Status', 'Start'));
end

end