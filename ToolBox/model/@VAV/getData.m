function getData(obj, nbr)

if nargin < 2
    obj.CurrentDataNb = obj.CurrentDataNb + 1;
    nbr = obj.CurrentDataNb;
end

% Define folders
i = length(obj.Limits) - sum(nbr < obj.Limits);

% Video name
vName = ['clip_', num2str(nbr), '.avi'];
fName = [num2str(i), '.', lower(obj.Folders{i})];

% Get file names
dataFile   = fullfile(obj.Path, 'stimuli', fName,  vName);

fixVFile   = fullfile(obj.Path, 'fixations', 'visual', ...
    ['clip_', num2str(nbr), '.mat']);
fixAVFile  = fullfile(obj.Path, 'fixations', 'audiovisual', ...
    ['clip_', num2str(nbr), '.mat']);

% Load datas
disp(dataFile)
obj.Stimuli    = VideoReader(dataFile);
obj.VFixation  = load(fixVFile);
obj.AVFixation = load(fixAVFile);

end
