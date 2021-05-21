function [d1,I] = joinColumns(d1,d2,V)
% Inputs:
% object d1 - original data set
% object d2 - new data set

if nargin == 2
    
    [d1,I] = ifIsArray(d1,d2);
    
    
elseif nargin == 3
    
    [d1,I] = ifIsArray(d1,d2,V);
    
end


function [d1,I]  = ifIsArray(d1,d2,V)

% d2 = alwaysCol(d2);

if isempty(d1)
    I  = 1:size(d2,2);
    d1 = d2;
else
    if nargin == 2
        I = size(d1,2) + (1:size(d2,2));
    elseif nargin == 3
        I = V - 1 + (1:size(d2,2));
    end
    d1(:,I) = d2;
end


