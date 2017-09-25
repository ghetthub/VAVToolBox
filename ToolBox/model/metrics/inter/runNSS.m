function score = runNSS(SM, FM)
% RUNNSS Runs NSS metric applied on fixation map and saliency map.
%
%   SCORE = RUNNSS(SM, FM) returns the Normalized Scanpath Saliency between
%   a human fixation map FM (binary map) and correponding saliency map SM.
%   
%   NSS is defined as the mean value of the normalized saliency map at
%   fixation locations.
%
%   See  "Saliency  and  Human  Fixations:  State-of-the-art  and  Study of
%   Comparison  Metrics"  from Riche et al. 2013,  for further informations
%   on this metric.

%   Created by Pierre Marighetto, January 2015
%   Based on code by Zoya Bylinskii, Aug 2014

% We resize the saliency map to the fixation map size (reference)
SM = imresize(SM, size(FM));

% Normalize saliency map.
% We want the new map to have a 0 mean and unit standard deviation.
SM = (SM - mean(SM(:)))/std(SM(:));

% mean value at fixation locations
score = mean(SM(logical(FM)));

end