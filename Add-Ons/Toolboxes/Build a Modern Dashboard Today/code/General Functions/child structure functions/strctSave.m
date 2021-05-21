function Data = strctSave(Data,Info,V,W)

switch length(V)
    case 0, Data = Info;
    case 1, Data.(W).(V{1}) = Info;
    case 2, Data.(W).(V{1}).(W).(V{2}) = Info;
    case 3, Data.(W).(V{1}).(W).(V{2}).(W).(V{3}) = Info;
    case 4, Data.(W).(V{1}).(W).(V{2}).(W).(V{3}).(W).(V{4}) = Info;
    case 5, Data.(W).(V{1}).(W).(V{2}).(W).(V{3}).(W).(V{4}).(W).(V{5}) = Info;
end


end

