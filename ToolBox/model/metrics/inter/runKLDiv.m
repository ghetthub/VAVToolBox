function score = runKLDiv(SM, FM)
% RUNKLDIV Runs the Kullback-Leibler divergenge applied on fixation map and 
% saliency map.
%
%   SCORE = RUNKLDIV( SM, FM ) returns  Kullback-Leibler divergenge between 
%   a human fixation map FM (binary map) and corresponding saliency map SM.
%
%   A score of 0 means SM is strictly equal to FM.
%   This metric has no maximum value.
%
%   See  "Saliency  and  Human  Fixations:  State-of-the-art  and  Study of
%   Comparison  Metrics"  from Riche et al. 2013,  for further informations
%   on this metric.

%   Created by Pierre Marighetto, January 2015

% We resize the saliency map to the fixation map size (reference).
SM = imresize(SM, size(FM));

% Normalization.
% We want the sum of SM elements equals to 1 (as well as for FM).
% eps is used to avoid division by 0 (quite improbable).
SM = SM / (sum(SM(:)) + eps);
FM = FM / (sum(FM(:)) + eps);

% Matrix containing all the calculated logarithms.
map = log((FM ./ (SM + eps)) + eps);

% Score is the sum of every logarithms where a fixation point is located
score = sum(sum(FM.*map));

end