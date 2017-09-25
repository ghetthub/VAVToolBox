addpath './inter'
addpath '../../model'

database = VAV();

metrics = {'cc', 'kldiv', 'nss', 'sim'};

database.CurrentDataNb = 19;

while database.hasData()
    database.getData();
    disp(['Video ', num2str(database.CurrentDataNb)]);
    
    scores = zeros(6, size(database.VFixation, 3));
    index = 1;
    while database.Stimuli.hasFrame()
       [~, fixV, fixAV, densV, densAV] = database.readFrames();
       
       scores(1,index) = runCC(densV, densAV);
       scores(2,index) = runKLDiv(densV, fixAV);
       scores(3,index) = runKLDiv(densAV, fixV);
       scores(4,index) = runNSS(densV, fixAV);
       scores(5,index) = runNSS(densAV, fixV);
       scores(6,index) = runSimilarity(densV, densAV);
       
       index = index + 1;
    end
    
    score = scores(1,:);
    save(['../../../Metrics/inter/cc/clip_', ...
        num2str(database.CurrentDataNb), '.mat'], 'score');
    score = scores(2,:);
    save(['../../../Metrics/inter/kldiv/visual/clip_', ...
        num2str(database.CurrentDataNb), '.mat'], 'score');
    score = scores(3,:);
    save(['../../../Metrics/inter/kldiv/audiovisual/clip_', ...
        num2str(database.CurrentDataNb), '.mat'], 'score');
    score = scores(4,:);
    save(['../../../Metrics/inter/nss/visual/clip_', ...
        num2str(database.CurrentDataNb), '.mat'], 'score');
    score = scores(5,:);
    save(['../../../Metrics/inter/nss/audiovisual/clip_', ...
        num2str(database.CurrentDataNb), '.mat'], 'score');
    score = scores(6,:);
    save(['../../../Metrics/inter/sim/clip_', ...
        num2str(database.CurrentDataNb), '.mat'], 'score');
end