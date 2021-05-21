function [d1,I] = joinRows(d1,d2,V)
% Inputs:
% object d1 - original data set
% object d2 - new data set

if isempty(d1), I = 1:size(d2,1);  d1 = d2; else
    if nargin == 2, I = size(d1,1) + (1:size(d2,1));
    elseif nargin == 3, I = V - 1 + (1:size(d2,1));
    end,  d1(I,:) = d2;
end


end



% the previous function was unnessisary*
% function [d1,I] = joinRows(d1,d2,V)
% % Inputs:
% % object d1 - original data set
% % object d2 - new data set
% 
% switch nargin
%     case 2, [d1,I] = ifIsArray(d1,d2); 
%     case 3, [d1,I] = ifIsArray(d1,d2,V);
% end
% 
% end
% 
% function [d1,I] = ifIsArray(d1,d2,V)
% 
% % d2 = alwaysRow(d2,'specific');
% 
% if isempty(d1), I = 1:size(d2,1);  d1 = d2; else
%     if nargin == 2, I = size(d1,1) + (1:size(d2,1));
%     elseif nargin == 3, I = V - 1 + (1:size(d2,1));
%     end,  d1(I,:) = d2;
% end
% 
% end

