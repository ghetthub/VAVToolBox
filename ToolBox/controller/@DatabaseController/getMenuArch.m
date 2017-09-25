function menuStruct = getMenuArch(obj)

fields = obj.Datas.Folders;

for i = 1:length(fields)
    menuStruct.(fields{i}) = obj.Datas.Limits(i) : obj.Datas.Limits(i+1) - 1;
end

end

