classdef DatabaseController < handle & hgsetget & matlab.mixin.CustomDisplay
    % DATABASECONTROLLER Controller used to link the view and the database.
    
    %------------------------------------------------------------------
    % General properties (in alphabetic order)
    %------------------------------------------------------------------
    properties(GetAccess='public', SetAccess='private')
        Datas
        Metrics
    end
    
    %------------------------------------------------------------------
    % Metric properties
    %------------------------------------------------------------------
    properties(GetAccess='public', SetAccess='public')
        EnabledDensity
        EnabledHybrid
        EnabledFixation
        EnabledScanpath
    end
    
    events
        DataRead
        FrameRead
    end
    
    %------------------------------------------------------------------
    % Documented methods
    %------------------------------------------------------------------
    methods(Access='public')
        
        %------------------------------------------------------------------
        % Lifetime
        %------------------------------------------------------------------
        function obj = DatabaseController()
            % General properties
            obj.Datas   = VAV();
            obj.Metrics = MetricScores();
            
            % Enabled
            obj.EnabledDensity  = [1 1];
            obj.EnabledHybrid   = [1 1];
            obj.EnabledFixation = 1;
            obj.EnabledScanpath = [0 0];
        end
        
        %------------------------------------------------------------------
        % Operations
        %------------------------------------------------------------------
        getData(obj, nbr);
        
        function readFrames(obj)
            % Video
            [video, fixV, fixAV, densV, densAV] = obj.Datas.readFrames();
            videoData = SentData('video', video, 'fixV', fixV, 'fixAV', ...
                fixAV, 'densV', densV, 'densAV', densAV);
            
            % Metric
            [kld, nss, cc, sim, disp] = ...
                obj.Metrics.readFrames(obj.Datas.CurrentFrame);
            hybrid = [kld; nss];
%             hybrid = hybrid(logical(obj.EnabledHybrid))';
            density = [cc, sim];
%             density = density(logical(obj.EnabledDensity))';
            fixation = disp;
%             fixation = fixation(logical(obj.EnabledFixation))';
            
            metricData = SentData('hybrid', hybrid, 'density', density, ...
                'fixation', fixation);
            
            % Trigger event
            notify(obj, 'FrameRead', ...
                FrameRead('Status', 'Ok', 'Data', videoData, 'Metric', metricData));
        end
        
        getNextFrame(obj);
        getPreviousFrame(obj);
        getFrame(obj, nbr);
        
        menuStruct = getMenuArch(obj);
    end
end