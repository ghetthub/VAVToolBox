function h = plotMetric(metric)

plotColors = load('plotColors.mat');

isSym   = false;
isInter = false;
title = '';

switch(metric)
    case('cc')
        isSym   = true;
        isInter = true;
        title   = 'CC';
    case('sim')
        isSym   = true;
        isInter = true;
        title   = 'Similarity';
    case('kldiv')
        isSym   = false;
        isInter = true;
        title   = 'KL-Divergence';
    case('nss')
        isSym   = false;
        isInter = true;
        title   = 'NSS';
    case('disp')
        isSym   = false;
        isInter = false;
        title   = 'Dispersion';
    case('scl')
        isSym   = false;
        isInter = false;
        title   = 'Scanpath Length';
    case('va')
        isSym   = false;
        isInter = false;
        title   = 'Visual Angle';
end

index = 1;

if isSym
    scores = zeros(3,1);
    values = zeros(99,1);
else
    scores = zeros(3,2);
    values = zeros(99,2);
end


if isInter
    folder = 'inter';
else
    folder = 'intra';
end

for nb = 1:99
    if nb == 35
        index = 2;
    end
    if nb == 55
        index = 3;
    end
    
    if isSym
        fileName = fullfile(folder, metric, ['clip_', num2str(nb), '.mat']);
        metricMat = load(fileName);
        value = mean(metricMat.score);
        
        values(nb) = value;
        scores(index) = scores(index) + value;
    else
        fileName = fullfile(folder, metric, 'visual', ...
            ['clip_', num2str(nb), '.mat']);
        metricMat = load(fileName);
        value = mean(metricMat.score);
        
        values(nb, 1) = value;
        scores(index, 1) = scores(index, 1) + value;
        
        fileName = fullfile(folder, metric, 'audiovisual', ...
            ['clip_', num2str(nb), '.mat']);
        metricMat = load(fileName);
        value = mean(metricMat.score);
        
        values(nb, 2) = value;
        scores(index, 2) = scores(index, 2) + value;
    end
end

scores(1,:) = scores(1,:) / 34;
scores(2,:) = scores(2,:) / 20;
scores(3,:) = scores(3,:) / 45;

stdScores = cat(1, std(values(1:34, :)) / sqrt(34), ...
    std(values(35:54,  :)) / sqrt(20), ...
    std(values(55:end, :)) / sqrt(45));

h = bar(scores);
hold on;
plotErrorBars(scores, stdScores);

set(gca, 'XTickLabel', {'Objects', 'Landscapes', 'Faces'});
ylabel(title, 'Rotation', 0, 'HorizontalAlignment', 'right');

if isSym
    h.FaceColor = plotColors.colors(4,:);
else
    h(1).FaceColor = plotColors.colors(4,:);
    h(2).FaceColor = plotColors.colors(3,:);
    legend('Visual', 'AudioVisual');
end

end

function plotErrorBars(scores, scoreStd)

numgroups = size(scores, 1);
numbars   = size(scores, 2);

groupwidth = min(0.8, numbars/(numbars+1.5));
for i = 1:numbars
    x = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars);
    errorbar(x, scores(:,i), scoreStd(:,i), 'k', 'linestyle', 'none');
end

end