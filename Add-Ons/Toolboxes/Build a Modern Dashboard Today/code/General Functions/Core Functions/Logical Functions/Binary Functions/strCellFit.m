function FitNames = strCellFit(names,n)
% Used for creating binary latice structures
% name are the names by which you are using to create the structure
% n is the number of connections per node.

Size = size(names);
if Size(1) > Size(2)
    names = names';
end

if length(names) < n
    FitNames = names;
    return
end

Data = GenerateBinBound(n,length(names));

for i = 1:size(Data,1)
    if i == 1
        FitNames = names(logical(Data(i,:)));
    else
        FitNames(i,:) = names(logical(Data(i,:)));
    end
end

end

