function score = runSimilarity(SM, FM)
%RUNSIMILARITY Similarity between normalized  saliency  map and  normalized
%fixation map.
%  SCORE = RUNSIMILARITY(SM, FM) is  similarity between normalized saliency
%  map SM and the human fixation map FM (binary matrix).
%  Maps  are  normalized  to  make  the sum of  all pixels equal to 1,  and
%  pixels values are between 0 and 1.
%
%  See  "Saliency  and  Human  Fixations:  State-of-the-art  and  Study  of
%  Comparison  Metrics"  from Riche et al. 2013,  for  further informations
%  on this metric.
%
%  Created by Pierre Marighetto, January 2015

% We resize the saliency map to the fixation map size (reference)
map = imresize(SM, size(FM));

% Normalized saliency map
map = mat2gray(map);
map = map / sum(map(:));

% Normalized fixation map
% Its a binary map so already in the range [0, 1]
FM = FM / sum(FM(:));

% The score is the sum of the minimum for each pixel,  between saliency map
% and fixation map
score = sum(sum( min(map,FM) ));

end
