function score = runCC(SM, FM)
%RUNCC Runs Pearson Correlation coefficient computation (CC)
%
%   SCORE = RUNCC(SM, FM) computes the linear correlation coefficient 
%   between the human fixation map FM (binary matrix) and saliency map SM, 
%   also called the Pearson Correaltion Coefficient
%
%   See  "Saliency  and  Human  Fixations:  State-of-the-art  and  Study of
%   Comparison  Metrics"  from Riche et al. 2013,  for further informations
%   on this metric.

%  Created by Pierre Marighetto, January 2015

% We resize the saliency map to the fixation map size (reference)
SM = im2double(imresize(SM, size(FM)));
FM = im2double(FM);

% We normalize both maps. 
% We want the new maps to have a 0 mean and unit standard deviation.
SM = (SM - mean2(SM)) / std(SM(:));
FM = (FM - mean2(FM)) / std(FM(:));

% Matlab already contains a function to calculate this coefficient
score = corr2(SM, FM);

end
     