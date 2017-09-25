function getData(obj, nbr)

if nargin < 2
    obj.CurrentDataNb = obj.CurrentDataNb + 1;
    nbr = obj.CurrentDataNb;
end

fileName    = ['clip_', num2str(nbr), '.mat'];

% Get file names (inter metrics)
metricsPath = fullfile(obj.Path, 'inter');

% Hybrid metrics
KLDVFile  = fullfile(metricsPath, 'kldiv/visual',      fileName);
KLDAVFile = fullfile(metricsPath, 'kldiv/audiovisual', fileName);
NSSVFile  = fullfile(metricsPath, 'nss/visual',        fileName);
NSSAVFile = fullfile(metricsPath, 'nss/audiovisual',   fileName);

% Density metrics
CCFile  = fullfile(metricsPath, 'cc',  fileName);
SimFile = fullfile(metricsPath, 'sim', fileName);

% Get file names (intra metrics)
metricsPath = fullfile(obj.Path, 'intra');

% Fixation metric
DispVFile  = fullfile(metricsPath, 'disp', 'visual',      fileName);
DispAVFile = fullfile(metricsPath, 'disp', 'audiovisual', fileName);

% Load datas (inter metrics)
obj.KLD = [load(KLDVFile), load(KLDAVFile)];
obj.NSS = [load(NSSVFile), load(NSSAVFile)];
obj.CC  = load(CCFile);
obj.Sim = load(SimFile);

% Load datas (intra metrics)
obj.Disp = [load(DispVFile), load(DispAVFile)];

end

