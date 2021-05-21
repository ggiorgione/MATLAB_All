%% Modal Split

Modes = 5;
ModesNum = [];
ModesNum(Modes,length(sim)) = 0;
colorModes = ([0.43 0.68 0.63; 0.86 0.86 0.86; 0.66 0.73 0.62; 1 0.31 0; 0.5 0.7 0.7]);

incomeBin = 5;
maxIncomeAccepted =  25;    %Max 100
binLimit = 60;

close

%Title Layout for the Modal Share
TL1 = 2;
TL2 = 4;

for i = 1:length(sim)
    input.Mode1 = sprintf('/Users/giulio.giorgione/Documents/MATLAB/HybridPricing/Python/');
    input.Mode2 = whichLoop;
    input.Mode3 = sprintf('/BasicPlan4CS_%s',sim{i});
    input.Mode4 = sprintf('.txt');
    inputMode = strcat(input.Mode1,input.Mode2,input.Mode3,input.Mode4);
    delimiterIn = "\t";
    
    BasicPlan4CS = readtable(inputMode,'Delimiter','\t');
    BasicPlan4CS = table2array(BasicPlan4CS(:,4));
    BasicPlan4CS = BasicPlan4CS(~cellfun('isempty',BasicPlan4CS));
    Modes = [];
    
    % bike - car - pt - twoway_vehicle - walk
    Modes = unique(BasicPlan4CS);
    Modes = sortrows(Modes);
    
    if isequal(Modes(4),{'twoway_vehicle'})
        ModesLegend = Modes;
        ModesLegend(4) = {'carsharing'};
    end
    
    
    %calculate the number of times a mode appears in BasicPlan4CS
    for j = 1:length(BasicPlan4CS)
        for k = 1:length(Modes)
            ModesNum(k,i) = ModesNum(k,i) + isequal(BasicPlan4CS(j),Modes(k));
        end
    end
end

ModesNum = ModesNum';
ModesNumSum = sum(ModesNum,2);
ModesNum = ModesNum';
ModesNumSum = ModesNumSum';
ModesNumPerc = (ModesNum./ModesNumSum)*100;

if DemandProfilePlot == 1
    histoBar = barh(ModesNumPerc', 'stacked');
    title('Modal Split');
    yticklabels(sim);
    xlabel('[%]');
    xticks(0:10:100);
    xlim([0 100]);
    for i = 1:size(ModesNumPerc,1)
        histoBar(i).FaceColor = colorModes(i,:);
    end
    grid on
    
    legend(ModesLegend,'Location','bestoutside');
    filename = [];
    filename.a = sprintf('Modal Split_');
    filename.b = whichLoop;
    filename.c = sprintf('.png');
    filename = strcat(filename.a,filename.b,filename.c);
    saveas(gca,filename);
end

%% Modal Split by Income

%Title Layout for the Modal Share

for i = 1:length(sim)
    input.Mode1 = sprintf('/Users/giulio.giorgione/Documents/MATLAB/HybridPricing/Python/');
    input.Mode2 = whichLoop;
    input.Mode3 = sprintf('/BasicPlan4CS_%s',sim{i});
    input.Mode4 = sprintf('.txt');
    inputMode = strcat(input.Mode1,input.Mode2,input.Mode3,input.Mode4);
    delimiterIn = "\t";
    
    BasicPlan4CS = readtable(inputMode,'Delimiter','\t');
    IDs4Modes_temp = [table2array(BasicPlan4CS(:,1)) table2array(BasicPlan4CS(:,4))];
    BasicPlan4CS = table2array(BasicPlan4CS(:,4));
    BasicPlan4CS = BasicPlan4CS(~cellfun('isempty',BasicPlan4CS));
    Modes = [];
    
    idx1 = ~strcmp(IDs4Modes_temp, {'-'});
    idx2 = ~cellfun(@isempty,IDs4Modes_temp);
    idx = [idx1(:,1) idx2(:,2)];
    idx(:,1) = idx(:,1).*idx(:,2);
    idx(:,2) = idx(:,1).*idx(:,2);
    
    for j = 1:length(IDs4Modes_temp)
        if idx(j,1) == 1
            IDs4Modes(j,:) = IDs4Modes_temp(j,:);
        end
    end
    
    IDs4Modes = IDs4Modes(~cellfun(@isempty,IDs4Modes));
    IDs4Modes_temp2 = reshape(IDs4Modes,[length(IDs4Modes)/2,2]);
    IDs4Modes = IDs4Modes_temp2;
    
    clear IDs4Modes_temp2
    clear IDs4Modes_temp
    clear IDs4ModesIncome
    
    IDs4Modes_temp = str2double(IDs4Modes(:,1));
    
    for j = 1:length(IDs4Modes)
        for k = 1:length(Agents)
            if IDs4Modes_temp(j,1) == Agents(k,1)
                IDs4ModesIncome(j,:) = [IDs4Modes(j,:) num2cell(Agents(k,4))];
            end
        end
    end
    
    clear IDs4Modes_temp
    
    % bike - car - pt - twoway_vehicle - walk
    Modes = unique(BasicPlan4CS);
    Modes = sortrows(Modes);
    IDs4Modes_temp = cell2mat(IDs4ModesIncome(:,3));
    
    for j = 1:length(IDs4ModesIncome) 
        for k = 1:length(incomeBinStepsPlusOne)
            if IDs4Modes_temp(j) < incomeBinStepsPlusOne(k)
                IDs4ModesIncome(j,4) = num2cell(incomeBinStepsPlusOne(k-1));
                break
            end
        end
    end
    
    IDs4ModesIncome = sortrows(IDs4ModesIncome,3);
   
    for j = 1:length(incomeBinSteps)
        for jj = 1:length(IDs4ModesIncome)
            if cell2mat(IDs4ModesIncome(jj,4)) == incomeBinSteps(j)
                ModesIncome.(incomeBinStepsString{j})(jj,:) = IDs4ModesIncome(jj,:);
            end
        end
    end
    
    for j = 1:length(incomeBinSteps)
        ModesIncome.(incomeBinStepsString{j}) = ModesIncome.(incomeBinStepsString{j})...
            (~cellfun('isempty',ModesIncome.(incomeBinStepsString{j})));
        ModesIncome.(incomeBinStepsString{j}) = reshape(ModesIncome.(incomeBinStepsString{j}),...
            [length(ModesIncome.(incomeBinStepsString{j}))/size(IDs4ModesIncome,2),size(IDs4ModesIncome,2)]);
    end
        
    saveMI.(sim{i}) = ModesIncome;
    clear ModesIncome
end

clear ModesNum

for i = 1:length(sim)
    for j = 1:length(incomeBinSteps)
        for k = 1:length(Modes)
            idx = ~strcmp(saveMI.(sim{i}).(incomeBinStepsString{j})(:,2),Modes(k));
            ModesNum.(sim{i})(k,j) = sum(idx);
            clear idx
        end
    end
end


for k = 1:length(sim)
    for j = 1:length(incomeBinSteps)
        nexttile
        for i = 1:length(Modes)
            for ii = 1:length(saveMI.(sim{k}).(incomeBinStepsString{j}))
                saveMICount.(sim{k}).(incomeBinStepsString{j})(i,ii) =...
                isequal(saveMI.(sim{k}).(incomeBinStepsString{j})(ii,2),Modes(i));
            end
            saveMICount.(sim{k}).(incomeBinStepsString{j}) = ...
                sum(saveMICount.(sim{k}).(incomeBinStepsString{j}),2);
        end
    end
end

close 

for k = 1:length(sim)
    for j = 1:(maxIncomeAccepted/incomeBin)+1
        saveMICountTot.(sim{k})(:,j) = saveMICount.(sim{k}).(incomeBinStepsString{j});
    end
end

close

if DemandProfilePlot == 1
    tiledlayout(TL1,TL2)
    for k = 1:length(sim)
        nexttile
        toHist = (saveMICountTot.(sim{k})./sum(saveMICountTot.(sim{k})))*100;
        histoBar = barh(toHist','stacked');
        title(sim{k});
        lab.a = string(incomeBinSteps);
        lab.b = ' - ';
        lab.c = string(incomeBinSteps+5);
        lab.d = strcat(lab.a,lab.b,lab.c);
        if k == 1 || k == TL2+1
            ylabel('Income [€/h]')
            yticklabels(lab.d);
            xlabel('[%]');
        else
            set(gca,'YTickLabel',[]);
        end
        xticks(0:10:100);
        xlim([0 100]);
        for i = 1:size(ModesNumPerc,1)
            histoBar(i).FaceColor = colorModes(i,:);
        end
        grid on
    end
    legend(ModesLegend,'Location','bestoutside');
    

    filename = [];
    filename.a = sprintf('Modal Share by Income_');
    filename.b = whichLoop;
    filename.c = sprintf('.png');
    filename = strcat(filename.a,filename.b,filename.c);
    saveas(gca,filename);
end

close
