function plotPaperFigures()
% PLOTPAPERFIGURES Plots the figures used in the associated paper.


% Metrics names
metrics = {'cc', 'sim', 'kldiv', 'nss', 'disp', 'scl', 'va'};

% Category 1: inter, density comparison
f = figure('Name', 'Inter population metrics comparing densities');

for metric = 1:2
    subplot(2,1,metric);
    plotMetric(metrics{metric});
end

saveas(f, 'inter_density', 'epsc');

% Category 2: inter, hybrid
f = figure('Name', 'Inter population hybrid metrics');

for metric = 3:4
    subplot(2,1,metric-2);
    plotMetric(metrics{metric});
end

saveas(f, 'inter_hybrid', 'epsc');

% Category 3: intra, fixation comparison
f = figure('Name', 'Intra population metric comparing fixations');

metric = 5;
plotMetric(metrics{metric});
saveas(f, 'intra_fixation', 'epsc');

% Category 4: intra, scanpath comparison
% for metric = 6:7
%     h = plotMetric(metrics{metric});
%     saveas(h, metrics{metric}, 'epsc');
% end

end