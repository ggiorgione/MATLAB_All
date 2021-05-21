function [sumOut] = bin2Decimal(DataT,Direction)
% Convert a Binary number to a decimal
% Input:  A Binary number
% Output: A decimal Number


SZ     = size(DataT);      
sumOut = zeros([SZ(1) 1]);

for j = 1:SZ(1)
    
    Data = DataT(j,:);
    
    Data = Data';
    Data = flipud(Data);
    Data = Data';
    
    sum = 0;
    DataLength = length(Data);
    
    for i = 1:DataLength
        sum = sum + Data(1,i)*2^(i-1);
    end
    
    sumOut(j) = sum;

end

if nargin == 2
    sumOut = sumOut.*Direction;
else
    return
end


end


