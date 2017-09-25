function getData(obj, nbr)

if nargin < 2
    obj.Datas.getData();
    obj.Metrics.getData();
else
    obj.Datas.getData(nbr);
    obj.Metrics.getData(nbr);
end

i = length(obj.Datas.Limits) - sum(obj.Datas.CurrentDataNb < obj.Datas.Limits);

metrics = SentData('disp', obj.Metrics.Disp);
datas   = SentData('name', ['Clip ', num2str(obj.Datas.CurrentDataNb)], ...
    'category', obj.Datas.Folders{i}, ...
    'nb_frame', size(obj.Metrics.Disp(1).score, 2));

notify(obj, 'DataRead', DataRead('Data', datas, 'Metric', metrics));

end