%% Scoring Variation Normal Distribution

for i = 1:length(sim)
    input.Score1 = sprintf('/Users/giulio.giorgione/Documents/MATLAB/HybridPricing/Python/');
    input.Score2 = whichLoop;
    input.Score3 = sprintf('/BasicPlan4CS_CS_%s',sim{i});
    input.Score4 = sprintf('.txt');
    inputScore = strcat(input.Score1,input.Score2,input.Score3,input.Score4);
    delimiterIn = "\t";
    
    BasicPlan4CSCS = readtable(inputScore,'Delimiter','\t');
    BasicPlan4CSCS = BasicPlan4CSCS(:,1:2);
    BasicPlan4CSCS = table2array(BasicPlan4CSCS);
    BasicPlan4CSCS(ismember(BasicPlan4CSCS,'-')) = [];
    BasicPlan4CSCS = reshape(BasicPlan4CSCS,[length(BasicPlan4CSCS)/2,2]);
    BasicPlan4CSCS = cellfun(@str2double,BasicPlan4CSCS);

    if DemandProfilePlot == 0
        BasicPlan4CSCS = sortrows(BasicPlan4CSCS,2);
        pd = fitdist(BasicPlan4CSCS(:,2),'Normal');
        scoreNorm = normpdf(BasicPlan4CSCS(:,2),pd.mu,pd.sigma); 
        a = plot(BasicPlan4CSCS(:,2),scoreNorm);
        a.Color = colorSims(i,:);
        b = xline(pd.mu);
        b.Color = colorSims(i,:);
        b.LineStyle = (':');
        b.LineWidth = (2);
        hold on
    end
end

if isequal(whichLoop,'FP')
    legend('FP','FP - Mean','TBDP010','TBDP010 - Mean','TBDP030',...
        'TBDP030 - Mean','ABDP105','ABDP105 - Mean','ABDP120',...
        'ABDP120 - Mean','FPRelocation','FPRelocation - Mean','TBDPRelocation', 'TBDPRelocation - Mean',...
        'Location', 'northwest');
else
    legend('MPP','MPP - Mean','TBDP010','TBDP010 - Mean','TBDP030',...
        'TBDP030 - Mean','ABDP105','ABDP105 - Mean','ABDP120',...
        'ABDP120 - Mean','MPPRelocation','MPPRelocation - Mean','ABDPRelocation', 'ABDPRelocation - Mean',...
        'Location', 'northwest');
end
        
if DemandProfilePlot == 0
%     title('Normal Distribution of the Score');
    filename = [];
    filename.a = sprintf('Normal Distribution of the Score_');
    filename.b = whichLoop;
    filename.c = sprintf('.png');
    filename = strcat(filename.a,filename.b,filename.c);
    saveas(gca,filename);
    legend(sim,'Location','best');
end

%% % Scoring Variation Cumulative
% for i = 1:length(sim)
% 
%     input.Score1 = sprintf('/Users/giulio.giorgione/Documents/MATLAB/HybridPricing/Python/');
%     input.Score2 = whichLoop;
%     input.Score3 = sprintf('/BasicPlan4CS_CS_%s',sim{i});
%     input.Score4 = sprintf('.txt');
%     inputScore = strcat(input.Score1,input.Score2,input.Score3,input.Score4);
%     delimiterIn = "\t";
%     
%     BasicPlan4CSCS = readtable(inputScore,'Delimiter','\t');
%     BasicPlan4CSCS = BasicPlan4CSCS(:,1:2);
%     BasicPlan4CSCS = table2array(BasicPlan4CSCS);
%     BasicPlan4CSCS(ismember(BasicPlan4CSCS,'-')) = [];
%     BasicPlan4CSCS = reshape(BasicPlan4CSCS,[length(BasicPlan4CSCS)/2,2]);
%     BasicPlan4CSCS = cellfun(@str2double,BasicPlan4CSCS);
% 
%     if DemandProfilePlot == 1
%         BasicPlan4CSCS = sortrows(BasicPlan4CSCS,2);
%         pd = fitdist(BasicPlan4CSCS(:,2),'Normal');
%         scoreNorm = normcdf(BasicPlan4CSCS(:,2),pd.mu,pd.sigma); 
%         a = plot(BasicPlan4CSCS(:,2),scoreNorm);
%         a.Color = colorSims(i,:);
%         xlim([0 1500]);
%         hold on
%     end
%     
%     clear pd
%     clear scoreNorm
%     clear BasicPlan4CSCS
% end
% 
% if isequal(whichLoop,'FP')
%     legend('FP','TBDP010','TBDP030',...
%         'ABDP105','ABDP120',...
%         'Location','bestoutside');
% else
%     legend('MPP','TBDP010','TBDP030',...
%         'ABDP105','ABDP120',...
%         'Location','bestoutside');
% end
%         
% if DemandProfilePlot == 1
%     title('Cumlative Distribution of the Score');
%     filename = [];
%     filename.a = sprintf('Cumlative Distribution of the Score_');
%     filename.b = whichLoop;
%     filename.c = sprintf('.png');
%     filename = strcat(filename.a,filename.b,filename.c);
%     saveas(gca,filename);
%     legend(sim,'Location','best');
% end

%% Scoring Cumulative
for i = 1:length(sim)

    input.Score1 = sprintf('/Users/giulio.giorgione/Documents/MATLAB/HybridPricing/Python/');
    input.Score2 = whichLoop;
    input.Score3 = sprintf('/BasicPlan4CS_CS_%s',sim{i});
    input.Score4 = sprintf('.txt');
    inputScore = strcat(input.Score1,input.Score2,input.Score3,input.Score4);
    delimiterIn = "\t";
    
    BasicPlan4CSCS = readtable(inputScore,'Delimiter','\t');
    BasicPlan4CSCS = BasicPlan4CSCS(:,1:2);
    BasicPlan4CSCS = table2array(BasicPlan4CSCS);
    BasicPlan4CSCS(ismember(BasicPlan4CSCS,'-')) = [];
    BasicPlan4CSCS = reshape(BasicPlan4CSCS,[length(BasicPlan4CSCS)/2,2]);
    BasicPlan4CSCS = cellfun(@str2double,BasicPlan4CSCS);
    
    IDIncome = [IDs4ModesIncome(:,1) IDs4ModesIncome(:,3) IDs4ModesIncome(:,4)];
    IDIncome_tempA = cellfun(@str2double,IDIncome(:,1));
    IDIncome_tempB = cell2mat(IDIncome(:,2));
    IDIncome_tempC = (floor(IDIncome_tempB/10))*10;
    IDIncome = [IDIncome_tempA IDIncome_tempB IDIncome_tempC];
    
    clear IDIncome_temp
    clear IDIncome_tempA
    clear IDIncome_tempB
    clear IDIncome_tempC
    
    for j = 1:length(BasicPlan4CSCS)
        for k = 1:length(IDIncome)
            if isequal(BasicPlan4CSCS(j,1),IDIncome(k,1))
                IDIncomeScore_temp(j,:) = [IDIncome(k,:) BasicPlan4CSCS(j,2)];
            end
        end
    end
    IDIncomeScore_temp = sortrows(IDIncomeScore_temp,2);
    IDIncomeScore.(sim{i}) = IDIncomeScore_temp;
    
    incomeUnique = unique(IDIncomeScore_temp(:,3));
    
    arrange = {'uno','due','tre','quattro','cinque','sei','sette','otto',...
        'nove','dieci'};
    
    for k = 1:length(incomeUnique)
        for j = 1:length(IDIncomeScore_temp)
            if isequal(incomeUnique(k),IDIncomeScore_temp(j,3))
                incomeUniqueScore_temp(j) = IDIncomeScore_temp(j,4);
            end
        end
        incomeUniqueScore.(arrange{k}) = mean(incomeUniqueScore_temp);
    end
    incomeUniqueScoreSim.(sim{i}) = incomeUniqueScore;
    
    clear incomeUniqueScore_temp
    clear incomeUniqueScore
    clear IDIncomeScore_temp
    clear IDIncomeScore
    clear incomeUnique
end
    
if DemandProfilePlot == 1
    axisMin = 1100;
    axisMax = 1300;
    if isequal(whichLoop,'FP')
        for i = 1:length(sim)
            for j = 1:length(fieldnames(incomeUniqueScoreSim.(sim{i})))
                VarPlot(i,j) = [incomeUniqueScoreSim.(sim{i}).(arrange{j})];
            end
        end
        spider_plot(VarPlot,...
            'AxesLabels', {'0 - 10 [€/h]', '10 - 20 [€/h]', '20 - 30 [€/h]',...
            '30 - 40 [€/h]', '40 - inf [€/h]'},...
            'AxesInterval', 2,...
            'FillOption', {'on', 'on', 'on', 'on', 'on', 'on', 'on'},...
            'FillTransparency', [0.05,0.05,0.05,0.05,0.05,0.05,0.05],...
            'LineStyle', {'-', '--', '--', ':', ':', '-', '-'},...
            'Color', colorSims,...
            'AxesLimits', [axisMin,axisMin,axisMin,axisMin,axisMin;...
            axisMax,axisMax,axisMax,axisMax,axisMax]);
            legend('FP','TBDP010','TBDP030','ABDP105','ABDP120','FPRelocation','TBDP010Relocation',...
                'Location','eastoutside');
    else
        for i = 1:length(sim)
            for j = 1:length(fieldnames(incomeUniqueScoreSim.(sim{i})))
                VarPlot(i,j) = [incomeUniqueScoreSim.(sim{i}).(arrange{j})];
            end
        end
        VarPlot(:,6:end) = [];
        if VarPlot(3,5) == 0
            VarPlot(3,5) = axisMin;
        end
        spider_plot(VarPlot,...
            'AxesLabels', {'0 - 10 [€/h]', '10 - 20 [€/h]', '20 - 30 [€/h]',...
            '30 - 40 [€/h]', '40 - inf [€/h]'},...
            'AxesInterval', 2,...
            'FillOption', {'on', 'on', 'on', 'on', 'on', 'on', 'on'},...
            'FillTransparency', [0.05,0.05,0.05,0.05,0.05,0.05,0.05],...
            'LineStyle', {'-', '--', '--', ':', ':', '-', '-'},...
            'Color', colorSims,...
            'AxesLimits', [axisMin,axisMin,axisMin,axisMin,axisMin;...
            axisMax,axisMax,axisMax,axisMax,axisMax]);
            legend('MPP','TBDP010','TBDP030','ABDP105','ABDP120','MPPRelocation','ABDP105Relocation',...
                'Location','eastoutside');
    end
    filename = [];
    filename.a = sprintf('SpiderPlot_ScoreMean_');
    filename.b = sprintf('%s',whichLoop);
    filename.c = sprintf('.png');
    filename = strcat(filename.a,filename.b,filename.c);
    saveas(gca,filename);
end

