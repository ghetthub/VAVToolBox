classdef VAV < hgsetget & matlab.mixin.CustomDisplay
    % VAV  Class used to define behavior of a VAV database.
    %
    %   Methods:
    %
    %   Properties:
    %     Name          - Full name of the database.
    %     Path          - Full path to the database.
    
    %   Created by Pierre Marighetto, November 2015
    
    %------------------------------------------------------------------
    % General properties (in alphabetic order)
    %------------------------------------------------------------------
    properties(GetAccess='public', SetAccess='private')
        Name                % Name of the database.
        NbData              % Number of datas.
        Path                % Path to the database.
    end
    
    %------------------------------------------------------------------
    % Current data properties (in alphabetic order)
    %------------------------------------------------------------------
    properties(GetAccess='public', SetAccess='public')
        CurrentDataNb       % Current data  read.
    end
    
    properties(GetAccess='public', SetAccess='private', Dependent)
        CurrentFrameRate    % Frame rate of the current data read.
    end
    
    properties(GetAccess='public', SetAccess='public', Dependent)
        CurrentFrame        % Current frame read in the current data.
        CurrentTime         % Current time  read in the current data.
    end
    
    %------------------------------------------------------------------
    % Stimuli properties (in alphabetic order)
    %------------------------------------------------------------------
    properties(GetAccess='public', SetAccess='private')
        Stimuli             % Stimuli (Datas object).
        Folders             % Folders containing the stimulis.
        Limits              % Video limit number for every folder.
    end
    
    %------------------------------------------------------------------
    % Visual ground-truth properties (in alphabetic order)
    %------------------------------------------------------------------
    properties(GetAccess='public', SetAccess='private')
        VFixation           % Human eye fixations for only visual.
    end
    
    %------------------------------------------------------------------
    % AudioVisual ground-truth properties (in alphabetic order)
    %------------------------------------------------------------------
    properties(GetAccess='public', SetAccess='private')
        AVFixation          % Human eye fixations for audio visual.
    end
    
    %------------------------------------------------------------------
    % Documented methods
    %------------------------------------------------------------------
    methods(Access='public')
        
        %------------------------------------------------------------------
        % Lifetime
        %------------------------------------------------------------------
        function obj = VAV()            
            % General properties
            obj.Name   = 'VAV (Visual vs AudioVisual)';
            obj.Path   = fullfile(fileparts(which(mfilename)), ...
                '../../../VAV');
            obj.NbData = 99;
            
            % Current data properties
            obj.CurrentDataNb = 0;
            
            % Stimuli properties
            obj.Folders = {'Objects', 'Landscapes', 'Faces'};
            obj.Limits  = [1, 35, 55, 100];
        end
        
        %------------------------------------------------------------------
        % Operations
        %------------------------------------------------------------------
        function value = hasData(obj)
            value = obj.CurrentDataNb < obj.NbData;
        end
        
        function [video, fixV, fixAV, densV, densAV] = readFrames(obj)
            video  = obj.Stimuli.readFrame();
            
            fixV   = double(obj.VFixation.eyemap (:, :, obj.CurrentFrame));
            fixAV  = double(obj.AVFixation.eyemap(:, :, obj.CurrentFrame));
            
            densV  = VAV.getDensities(fixV);
            densAV = VAV.getDensities(fixAV);
        end
        
        getData(obj, nbr);
    end
    
    %------------------------------------------------------------------
    % Custom Getters/Setters
    %------------------------------------------------------------------
    methods
        % Properties that are not dependent on underlying object.
        function name = get.Name(obj)
            name = obj.Name;
        end
        function set.Name(obj, value)
            validateattributes(value, {'char'}, {}, 'set', 'Name');
            obj.Name = value;
        end
        
        function path = get.Path(obj)
            path = obj.Path;
        end
        function set.Path(obj, value)
            validateattributes(value, {'char'}, {}, 'set', 'Path');
            obj.Path = value;
        end
        
        function nbr = get.NbData(obj)
            nbr = obj.NbData;
        end
        function set.NbData(obj, value)
            validateattributes(value, {'numeric'}, {}, 'set', 'NbData');
            obj.NbData = value;
        end
        
        function nbr = get.CurrentDataNb(obj)
            nbr = obj.CurrentDataNb;
        end
        function set.CurrentDataNb(obj, value)
            validateattributes(value, {'numeric'}, {}, 'set', 'CurrentDataNb');
            obj.CurrentDataNb = value;
        end
        
        % Properties that are dependent on underlying object.
        function nbr = get.CurrentFrame(obj)
            if obj.CurrentDataNb < 1
                nbr = NaN;
            else
                nbr = round(obj.Stimuli.CurrentTime * obj.Stimuli.FrameRate);
                nbr = min(nbr, size(obj.VFixation.eyemap, 3));
            end
        end
        function set.CurrentFrame(obj, value)
            validateattributes(value, {'numeric'}, {}, 'set', 'CurrentFrame');
            if obj.CurrentDataNb > 0
                obj.CurrentTime = value / obj.Stimuli.FrameRate;
            end
        end
        
        function nbr = get.CurrentFrameRate(obj)
            if obj.CurrentDataNb < 1
                nbr = NaN;
            else
                nbr = obj.Stimuli.FrameRate;
            end
        end
        function set.CurrentFrameRate(~, value)
            validateattributes(value, {'numeric'}, {}, 'set', 'CurrentFrameRate');
        end
        
        function nbr = get.CurrentTime(obj)
            if obj.CurrentDataNb < 1
                nbr = NaN;
            else
                nbr = obj.Stimuli.CurrentTime;
            end
        end
        function set.CurrentTime(obj, value)
            validateattributes(value, {'numeric'}, {}, 'set', 'CurrentTime');
            if obj.CurrentDataNb > 0
                obj.Stimuli.CurrentTime   = value;
            end
        end
    end
    
    %------------------------------------------------------------------
    % Overrides for Custom Display
    %------------------------------------------------------------------
    methods (Access='protected')
        function propGroups = getPropertyGroups(~)
            import matlab.mixin.util.PropertyGroup;
            
            propGroups(1) = PropertyGroup( {'Name', 'Path', 'NbData'}, ...
                'General Properties:' );
        end
    end
    
    %------------------------------------------------------------------
    % Overrides for Custom Display when calling get(obj)
    %------------------------------------------------------------------
    methods(Hidden)
        function getdisp(obj)
            display(obj);
        end
    end
    
    %------------------------------------------------------------------
    % Helpers
    %------------------------------------------------------------------
    methods(Static, Access='public')
        
        % - Computes densities from fixations. Can be used when densities
        % - are not giving by database creators. Otherwise, we recommend to
        % - use database creators' densities, as the computation may vary
        % - depending on the eye-tracking device.
        function densities = getDensities(fixations)
            [height, width, nb_frames] = size(fixations);
            densities = zeros(height, width, 1, nb_frames);
            
            dims = [50 50];
            P = [round(dims(1)/2) round(dims(2)/2)];
            [Xm, Ym] = meshgrid(-P(2):P(2), -P(1):P(1));
            gauss = exp(-((( Xm.^2)+( Ym.^2)) ./ (200)));
            
            for i = 1:nb_frames
                fixation = double(fixations(:,:,i));
                densities(:,:,:,i) = mat2gray(conv2(fixation, gauss, 'same'));
            end
        end
    end
    
end