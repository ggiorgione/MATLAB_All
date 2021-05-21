% Show give an example of how to use the factor analysis class:
% note: everything is simulated and should not be used to make any
% investment decisions.
% 
% For the first example the script will demonstrait how the feanalysis
% class can handle table data. In part II I will show how the class can
% handle raw data as well.

close all
clear

load stockreturns % obtain data:
stockNames = {'AMZN','TWTR','DIS','CVX','TLT','VZ','SWN','A','AA','AAA'};
Tbl = array2table(stocks,'VariableNames',stockNames);

%% Part I handle Table Data:

% generate factor analysis object:
obj = feanalysis(Tbl,3);
F = encode(obj,Tbl);

figure(1)
title('Factor Analysis Bar Plot'), hold on
barPlot(obj);

figure(2)
biPlot(obj);


%% Part II handle array Data:

obj = feanalysis(stocks,stockNames,3);
F = encode(obj,stocks,stockNames);

figure(3)
title('Factor Analysis Bar Plot')
barPlot(obj);

figure(4)
biPlot(obj);