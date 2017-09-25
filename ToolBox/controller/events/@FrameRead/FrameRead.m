classdef FrameRead < event.EventData
    properties
        Data
        Metric
        Status
    end
    
    methods
        function obj = FrameRead(varargin)
            for i = 1 : (nargin / 2)
                field = varargin{(2*i) - 1};
                value = varargin{2*i};
                
                obj.(field) = value;
            end
        end
    end
end