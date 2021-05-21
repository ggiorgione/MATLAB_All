function bin = GenerateBinBound(number,bits)
% Generates all binary vectors with a descrete number of ones that is
% defined by input number for a binary vector of length bits.
%
% Example
% number = 2
% bits   = 3
% [0 1 1] - Only 2 ones present
% [1 0 1] - Only 2 ones present
% [1 1 0] - Only 2 ones present


bin = zeros([(2^bits) bits]);


for i = 1:2^bits-1

    bin(i,:) = Decimal2Bin(i,bits);

end

bb =  sum(bin,2);

bin(bb(:,1) ~= number,:) = [];



end

