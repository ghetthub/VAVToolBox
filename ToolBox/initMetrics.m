function handles = initMetrics(handles)

plotColors = load('plotColors.mat');

YDens = max(max(handles.controller.Metrics.CC.score), ...
    max(handles.controller.Metrics.Sim.score)) + 1;

YHyb  = max(max([handles.controller.Metrics.KLD.score]), ...
    max([handles.controller.Metrics.NSS.score])) + 1;

YFix  = max(max([handles.controller.Metrics.Disp.score])) + 1;


h_density = bar(handles.density, [0 0]);
h_density(1).FaceColor = plotColors.colors(4,:);
set(handles.density, 'YLim', [-1 YDens]);
set(handles.density, 'XTickLabel', {'CC', 'Sim'});
title(handles.density, 'Inter - Density comparison');

h_hybrid = bar(handles.hybrid, [0 0; 0 0], 'grouped');
h_hybrid(1).FaceColor = plotColors.colors(4,:);
h_hybrid(2).FaceColor = plotColors.colors(3,:);
set(handles.hybrid, 'YLim', [-1 YHyb]);
set(handles.hybrid, 'XTickLabel', {'KL-Div', 'NSS'});
title(handles.hybrid, 'Inter - Hybrid');

h_fixation = bar(handles.fixation, [0 0]);
h_fixation(1).FaceColor = plotColors.colors(4,:);
set(handles.fixation, 'YLim', [-1 YFix]);
set(handles.fixation, 'XTickLabel', {'Visual', 'AudioVisual'});
title(handles.fixation, 'Intra - Fixation comparison');

end