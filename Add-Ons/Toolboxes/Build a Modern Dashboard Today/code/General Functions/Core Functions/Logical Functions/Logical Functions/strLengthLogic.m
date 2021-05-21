function Logic = strLengthLogic(str,n,symbol)

if nargin == 2
    symbol = ' ';
end

for i = 1:length(str)
    if i == 1
        Logic = length(stringHandler(str(i),symbol,'split')) == n;
    else
        Logic(i) = length(stringHandler(str(i),symbol,'split')) == n;
    end
end


end

