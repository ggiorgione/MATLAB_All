function Logic = isNumber(Data,plusNaN)

if isempty(Data) == 0
    Logic = isa(Data(1),'double') || isa(Data(1),'integer');
    if nargin == 2
        if Logic == 1
            Logic = isnan(Data) == plusNaN;
        end
    end
else
    Logic = false;
end


end

