% Symmetrical inter populations metrics 
interSimMetrics = {'cc', 'sim'};

% Non symmetrical inter populations metrics
interNoSimMetrics = {'kldiv', 'nss'};

% Intra  metrics
intraMetrics = {'disp', 'scl', 'va'};

for metric = 1:length(interSimMetrics)
    
    for nb = 1:99
        fileName = fullfile('inter', interSimMetrics{metric}, ...
            ['clip_', num2str(nb), '.mat']);
        metricMat = load(fileName);
        
        if sum(isnan(metricMat.score))
            score = metricMat.score;
            index = find(isnan(score));
            score(index) = 0;
            
            save(fileName, 'score');
            
            display([interSimMetrics{metric}, ' : ', num2str(nb), ' at ', num2str(index)]);
        end
    end
end

for metric = 1:length(interNoSimMetrics)
    
    for nb = 1:99
        fileName = fullfile('inter', interNoSimMetrics{metric}, 'audiovisual', ...
            ['clip_', num2str(nb), '.mat']);
        metricMat = load(fileName);
        value = mean(metricMat.score);
        
        if isnan(value)
            score = metricMat.score;
            index = find(isnan(score));
            score(index) = 0;
            
            save(fileName, 'score');
            
            display([interNoSimMetrics{metric}, ', audiovisual : ', num2str(nb), ' at ', num2str(index)]);
        end
        
        fileName = fullfile('inter', interNoSimMetrics{metric}, 'visual', ...
            ['clip_', num2str(nb), '.mat']);
        metricMat = load(fileName);
        value = mean(metricMat.score);
        
        if isnan(value)
            score = metricMat.score;
            index = find(isnan(score));
            score(index) = 0;
            
            save(fileName, 'score');
            
            display([interNoSimMetrics{metric}, ', visual : ', num2str(nb), ' at ', num2str(index)]);
        end
    end
end

for metric = 1:1
    
    for nb = 1:99
        fileName = fullfile('intra', intraMetrics{metric}, 'audiovisual', ...
            ['clip_', num2str(nb), '.mat']);
        metricMat = load(fileName);
        value = mean(metricMat.score);
        
        if isnan(value)
            score = metricMat.score;
            index = find(isnan(score));
            score(index) = 0;
            
            save(fileName, 'score');
            
            display([intraMetrics{metric}, ', audiovisual : ', num2str(nb), ' at ', num2str(index)]);
        end
        
        fileName = fullfile('intra', intraMetrics{metric}, 'visual', ...
            ['clip_', num2str(nb), '.mat']);
        metricMat = load(fileName);
        value = mean(metricMat.score);
        
        if isnan(value)
            score = metricMat.score;
            index = find(isnan(score));
            score(index) = 0;
            
            save(fileName, 'score');
            
            display([intraMetrics{metric}, ', visual : ', num2str(nb), ' at ', num2str(index)]);
        end
    end
end