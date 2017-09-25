classdef MetricScores < handle & hgsetget & matlab.mixin.CustomDisplay
    % METRICSCORES  Class used to define behavior of a metrics.
    %
    %   Methods:
    %
    %   Properties:
    %     Name          - Full name of the database.
    %     Path          - Full path to the database.
    
    %   Created by Pierre Marighetto, October 2015
    
    %------------------------------------------------------------------
    % General properties (in alphabetic order)
    %------------------------------------------------------------------
    properties(GetAccess='public', SetAccess='protected')
        Path                % Path to the metrics results.
        NbData              % Number of datas.
    end
    
    %------------------------------------------------------------------
    % Current data properties (in alphabetic order)
    %------------------------------------------------------------------
    properties(GetAccess='public', SetAccess='private')
        CurrentDataNb       % Current data  read.
    end
    
    %------------------------------------------------------------------
    % Inter metrics properties (in alphabetic order)
    %------------------------------------------------------------------
    properties(GetAccess='public', SetAccess='protected')
        KLD                 % Kullback-Leibler Divergence
        CC                  % Pearson's Correlation Coefficient
        Sim                 % Similarity
        NSS                 % Normalizes Scanpath Saliency
    end
    
    %------------------------------------------------------------------
    % Intra metrics properties (in alphabetic order)
    %------------------------------------------------------------------
    properties(GetAccess='public', SetAccess='protected')
        Disp                % Dispersion
    end
    
    %------------------------------------------------------------------
    % Documented methods
    %------------------------------------------------------------------
    methods(Access='public')
        function obj = MetricScores()
            % General properties
            obj.Path   = fullfile(fileparts(which(mfilename)), ...
                '../../../Metrics');
            obj.NbData = 99;
            
            % Current data properties
            obj.CurrentDataNb = 0;
        end
        
        %------------------------------------------------------------------
        % Operations
        %------------------------------------------------------------------
        function value = hasData(obj)
            value = obj.CurrentDataNb < obj.NbData;
        end
        
        
        function [kld, nss, cc, sim, disp] = readFrames(obj, nbr)
            % Inter metrics
            % Hybrid
            kld  = [obj.KLD(1).score(nbr), obj.KLD(2).score(nbr)];
            nss  = [obj.NSS(1).score(nbr), obj.NSS(2).score(nbr)];
            
            % Density
            cc   = obj.CC.score(nbr);
            sim  = obj.Sim.score(nbr);
            
            % Intra metrics
            % Fixation
            disp = [obj.Disp(1).score(nbr), obj.Disp(2).score(nbr)];
        end
        
        getData(obj, nbr);
    end
    
    %------------------------------------------------------------------
    % Custom Getters/Setters
    %------------------------------------------------------------------
    methods
        % Properties that are not dependent on underlying object.
        function name = get.Path(obj)
            name = obj.Path;
        end
        function set.Path(obj, value)
            validateattributes(value, {'char'}, {}, 'set', 'Path');
            obj.Path = value;
        end
        
        % Properties that are dependent on underlying object.
    end
    
    %------------------------------------------------------------------
    % Overrides for Custom Display
    %------------------------------------------------------------------
    methods (Access='protected')
        function propGroups = getPropertyGroups(obj)
            import matlab.mixin.util.PropertyGroup;
            
            propGroups(1) = PropertyGroup( {'Path'}, ...
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
    
end