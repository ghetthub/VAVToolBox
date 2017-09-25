classdef DataRead < event.EventData
    
    properties
        Data
        Metric
    end
    
    
    methods
        function obj = DataRead(varargin)
            for i = 1 : (nargin / 2)
                field = varargin{(2*i) - 1};
                value = varargin{2*i};
                
                obj.(field) = value;
            end
        end
    end
    
end