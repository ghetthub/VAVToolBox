for i = 1:99
    score = NSSStruct.(['clip_', num2str(i)]).NSS_V;
    save(['inter/nss/visual/clip_', num2str(i), '.mat'], 'score');
    
    score = NSSStruct.(['clip_', num2str(i)]).NSS_AV;
    save(['inter/nss/audiovisual/clip_', num2str(i), '.mat'], 'score');
    
    score = SimilarityStruct.(['clip_', num2str(i)]).S;
    save(['inter/sim/clip_', num2str(i), '.mat'], 'score');
    
    
end
