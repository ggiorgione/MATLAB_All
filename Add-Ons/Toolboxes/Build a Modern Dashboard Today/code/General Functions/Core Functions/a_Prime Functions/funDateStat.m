function [Dates,data,data2,data3] = funDateStat(dates,data,type)
% has the ability to caluate multiple statistic functions


switch type
    
    case 'mean', [Dates,data] = dateMeanFun(dates,data);
    case 'std', [Dates,data] = dateStdFun(dates,data);
    case 'var', [Dates,data] = dateVar(dates,data);
    case 'all', [~,data] = dateMeanFun(dates,data);
        [~,data2] = dateStdFun(dates,data);
        [Dates,data3] = dateVar(dates,data);
end

if nargout == 0 % plot function
   plotTimeData(Dates,data,'Dated Statistics','Independent Variable')
end


end

function [Dates,Mean] = dateMeanFun(dates,data)

Dates = flipud(unique(dates));
for i = 1:length(Dates), I = (dates == Dates(i));
    if i == 1, Mean = mean(data(I,:)); else, Mean(i,:) = mean(data(I,:));
    end
end


end


function [Dates,Std] = dateStdFun(dates,data)

Dates = flipud(unique(dates));
for i = 1:length(Dates), I = (dates == Dates(i));
    if i == 1, Std = std(data(I,:)); else, Std(i,:) = std(data(I,:)); end 
end


end


function [Dates,Var] = dateVar(dates,data)

Dates = flipud(unique(dates));
for i = 1:length(Dates), I = (dates == Dates(i));
    if i == 1,Var = var(data(I,:)); else,Var(i,:) = var(data(I,:)); end
end


end

