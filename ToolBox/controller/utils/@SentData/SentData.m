classdef SentData < hgsetget & matlab.mixin.CustomDisplay
    properties
        Values
    end
    
    methods
        function obj = SentData(varargin)
            for i = 1 : (nargin / 2)
                field = varargin{(2*i) - 1};
                value = varargin{2*i};
                
                obj.Values.(field) = value;
            end
        end
    end
end