function d1 = BlindJoin(d1,d2,Type)
% This function Joins to data type d1 and d2 without referencing and
% primary key. Main purpose is to merge data of the size size when user is
% fully aware that the corresponding rows corrilate to some attribute in
% the dataset.
%
% Inputs:
% object d1 - original data set
% object d2 - new data set
% type - how to join d2 to d1
% 
% Defult: Join a new col to array

switch nargin
    
    case 2
        
        if iscell(d2) == 1
            d1 = ifIsCell(d1,d2);
        else
            d1 = ifIsArray(d1,d2);
        end
        
    case 3
        
        if iscell(d2) == 1 && iscellstr(d2) == 0
            d1 = ifIsCell(d1,d2,Type);
        else
            d1 = ifIsArray(d1,d2,Type);
        end
end


function d1 = ifIsCell(d1,d2,Type)

if nargin == 2
    if isempty(d1)
        d1 = d2;
        return
    else
        d2Size = length(d2(1,:));
        
        d1{:,(end+1):(end + d2Size)} = d2;
        
    end
else
    switch Type
        case 'col'
            
            d2Size = length(d2(1,:));
            
            if isempty(d1)
                d1 = d2;
            else
                d1{:,(end+1):(end + d2Size),:} = d2;
            end
            
        case 'row'
            
            d2Size = length(d2(1,:));
            
            if isempty(d1)
                d1 = d2;
            else
                d1{(end+1):(end + d2Size)} = d2;
            end
    end
end


function d1 = ifIsArray(d1,d2,Type)

if nargin == 2
    if isempty(d1)
        d1 = d2;
        return
    else
        d2Size = length(d2(1,:));
        d1(:,(end+1):(end + d2Size)) = d2;
    end
else
    switch Type
        case 'col'
            
            d2Size = length(d2(1,:));
            if isempty(d1)
                d1 = d2;
            else
                d1(:,(end+1):(end + d2Size),:) = d2;
            end
            
        case 'row'
            
            d2Size = length(d2(1,:));
            if isempty(d1)
                d1 = d2;
            else
                d1((end+1):(end + d2Size)) = d2;
            end   
    end
end