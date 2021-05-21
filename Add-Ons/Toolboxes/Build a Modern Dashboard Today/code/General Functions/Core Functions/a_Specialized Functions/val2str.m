function str = val2str(value,type,Format)
% Converts the input amount to a string. funtion can Handle positive
% and negitive Values as well as NaN's.
% Input Value you wish to convert into a string.
% Output The Value converted into a string.
% -------------------------------------------------------------------------
% Function handles (type):
%     1. currency      2. doubles       3. percent      4. number

str = 'NaN'; if isnan(value), return, end
switch type
    case 'currency', str = double2currency(value); 
    case 'double',   str = double2str(value);
    case 'percent',  str = Double2Percent(value);
    case 'number',   str = num2Str(value); 
    case 'raw',      str = num2raw(value);
    otherwise
        error('Types: ''currency'',''double'',''percent'',''number'' ')
end, if nargout == 0, disp(str), end
if nargin == 3
    switch Format
        case 'char', str = charFormat(str);  
        case 'cell', str = cellstr(str);    
    end
end

end

% double to currency str
function d1 = double2currency(amount)
% Converts the input amount to a currency string. funtion Handles positive
% and negitive amounts as well as NaN's.
% Input Amount you wish to convert into a string.
% Output The Amount converted into a string.

d1 = [];
for i = 1:length(amount)
    
    str = fliplr(sprintf('%10.2f',abs(amount(i)))); str = regexprep(str,' ','');
    str = str(sort([1:length(str) 7:3:length(str)]));
    str(7:4:length(str)) = ','; str = ['$' fliplr(str)];
    if amount(i)<0, d1 = joinRows(d1,cellstr(['-' str])); else
        d1 = joinRows(d1,cellstr(str));
    end
end
end

% double to percent str
function str = Double2Percent(num)
% Converts the input amount to a Percent string. funtion Handles positive
% and negitive amounts as well as NaN's.
% Input Amount you wish to convert into a string.
% Output The Percent converted into a string.
% Function Can Handle Vectors


L = length(num);
if L == 1, str = sprintf('%.02f%%',round(num,2)); else, str = {'Percent'};
    for i = 1:L
        if isnan(num(i)), str(i) = {'NaN'}; else
            str(i) = {char(sprintf('%.02f%%',round(num(i),2)))}; 
        end
    end
end

end

% double 2 str
function d1 = double2str(Value)
% Converts the input amount to a string. funtion can Handle positive
% and negitive Values as well as NaN's.
% Input Value you wish to convert into a string.
% Output The Value converted into a string.
d1 = [];
for i = 1:length(Value)
    str = fliplr(sprintf(' %10.2f',abs(Value(i))));
    str = regexprep(str,' ','');
    str = str(sort([1:length(str) 7:3:length(str)]));
    str(7:4:length(str)) = ','; str = fliplr(str);
    if Value(i) < 0, d1 = joinRows(d1,cellstr(horzcat('-',str))); else
        d1 = joinRows(d1,cellstr(str));
    end
end

end

% number to str
function str = num2Str(Value)
% Converts the input amount to a string. funtion can Handle positive
% and negitive Values as well as NaN's.
% Input Value you wish to convert into a string.
% Output The Value converted into a string.

str = fliplr(sprintf('%10.0f',abs(Value))); str = regexprep(str,' ','');
str = str(sort([1:length(str) 7:3:length(str)]));
str(7:4:length(str)) = ','; str = fliplr(str);
if Value < 0, str = ['-' str]; end


end


% number to str
function str = num2raw(Value)
% Converts the input amount to a string. funtion can Handle positive
% and negitive Values as well as NaN's.
% Input Value you wish to convert into a string.
% Output The Value converted into a string.

str = sprintf('%10.0f',abs(Value));
str(str == ' ') = [];
if Value < 0, str = ['-' str]; end


end


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

function N  = charFormat( N )

if iscellstr(N),  N = char(N); end

end


