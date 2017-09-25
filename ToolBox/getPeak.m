function newFrame = getPeak(divVAV, curTime, cmpFnc)

[pks, locs] = findpeaks(divVAV);
X = find(pks > (mean(divVAV) + std(divVAV)));

if strcmp(cmpFnc, '<')
    X = fliplr(X);
    newFrame = 1;
else
    newFrame = length(divVAV);
end

found = false;
i = 1;

comparison = str2func(cmpFnc);

while i <= size(X,2) && ~found
    if comparison(locs(X(i)), curTime)
        newFrame = locs(X(i))-1;
        found = true;
    end
    i = i + 1;
end

end