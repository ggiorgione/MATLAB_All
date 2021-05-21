function [bin,D] = BinaryApproximation(Input,Range,bits)
% Given an Input, Section that given input into descete sections that can
% be represented by a binary number.
%
% Notes:
% Input - is a Value that needs to be in the domain of the range
% Range - is the range of your Input, [max, min]
% Bits  - is the bit number of your out put
%   a.) bit = 1, 2 descete cases
%   b.) bit = 2, 4 descete cases
%   c.) bit = 3, 9 descete cases

if nargout == 2
   D = ((Input/abs(Input)) == 0); 
end

switch length(Range)
    
    case 2 % Provided boundaries (linear)
        Sects = 2^bits - 1;
        Sects = (1:Sects).*(1/Sects);
        Value = flipud((((Range(1) - Range(2)).*Sects) + Range(2))');
        index = NumericIndexLocator(Value,Input);
        bin   = Decimal2Bin(index,bits);
        
    otherwise % Provided Vector bounderies (Non-linear)
        Sects = 2^bits - 1;
        base  = (length(Range))/Sects;
        TL    = length(Input);
        bin   = zeros([TL bits]);
        for i = 1:TL
            index = NumericIndexLocator(Range,Input(i));
            Value  = index/base;
            bin(i,:)   = Decimal2Bin(Value,bits);
        end
end

end

