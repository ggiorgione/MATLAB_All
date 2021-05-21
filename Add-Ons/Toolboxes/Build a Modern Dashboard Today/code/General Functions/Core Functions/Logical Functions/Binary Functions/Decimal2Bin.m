function [Binary,D] = Decimal2Bin(i,bits)
% Decimal to binary inputs a decimal number and coverts it to a binary
% vector. To define the number of bits present in the vector is defined by
% the input bits.
%
% Notes:
% i      - Intiger Number
% bits   - Number of bits in binary vector
% Binary - Output binary vector

if nargout == 2
   D = ((i/abs(i)) == 0); 
end

i = abs(i);

row = 0;

Binary = zeros([1 1]);

if i == 0
    Binary = 0;
else
    while i >= 1
        row = row + 1;
        modi = mod(i,2);
        i = (i/2);
        if modi == 0
            Binary(row,1) = 0;
        else
            Binary(row,1) = 1;
        end
        
        if i == 0
            row = row + 1;
            Binary(row,1) = 0;
        end
        i = floor(i);
        
    end
    
    Binary = flipud(Binary);
    Binary = Binary';
    
end

if nargin == 2
    
    TL     = length(Binary);
    ZN     = bits - TL;
    Filler = zeros([1 ZN]);
    Binary = [Filler Binary];
    
end


    
end
