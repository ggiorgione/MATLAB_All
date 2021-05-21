function Data = strctDive(Data,V,W)

switch length(V)
    case 1, Data = Data.(W).(V{1});
    case 2, Data = Data.(W).(V{1}).(W).(V{2});
    case 3, Data = Data.(W).(V{1}).(W).(V{2}).(W).(V{3});
    case 4, Data = Data.(W).(V{1}).(W).(V{2}).(W).(V{3}).(W).(V{4});
    case 5, Data = Data.(W).(V{1}).(W).(V{2}).(W).(V{3}).(W).(V{4}).(W).(V{5});
end

end

