% Walking Time Cumulative of the time per Income bin of 5€/h

incomeBin = 5;
maxIncomeAccepted =  25;    %Max 100
binLimit = 60;

colorHist = colorSims;

couple.(sim{2}) = [1 2]; %couple FP/TRB - TBDP010
couple.(sim{3}) = [1 3]; %couple FP/TRB - TBDP030
couple.(sim{4}) = [1 4]; %couple FP/TRB - ABDP105
couple.(sim{5}) = [1 5]; %couple FP/TRB - ABDP120
couple.(sim{6}) = [1 6]; %couple FP/TRB - Relocation
couple.(sim{7}) = [1 7]; %couple FP/TRB - Relocation


simAVG = strcat(sim,{' mean'});

%Title Layout for the Walking Time Cumulative
TL1 = 3;
TL2 = 3;

%% Demand Profile
for i = 1:length(sim)

    % Take the address of the csv and reads it in walkingTime
    input.CS1 = sprintf('/Users/giulio.giorgione/Documents/MATLAB/HybridPricing/WalkingTimeIndividual_');
    input.CS2 = whichLoop;
    input.CS4 = sprintf('_%s',sim{i});
    input.CS5 = sprintf('.csv');
    inputCS = strcat(input.CS1,input.CS2,input.CS4,input.CS5);
    delimiterIn = ",";
    walkingTime = readtable(inputCS,'Delimiter','\t');
    
    walkingTime = sortrows(walkingTime,2,'ascend');
    walkingTimeIncomeBin = walkingTime(:,2);
    walkingTimeIncomeBin = table2array(walkingTimeIncomeBin);
    walkingTimeIncomeBinMin = min(walkingTimeIncomeBin);
    walkingTimeIncomeBinMAX = max(walkingTimeIncomeBin);
    incomeBinSteps(1,1) = 0;
    
    for j = 2:walkingTimeIncomeBinMAX/incomeBin
        incomeBinSteps(j,:) = incomeBinSteps(j-1,:)+incomeBin;
    end
    incomeBinSteps(j+1,1) = walkingTimeIncomeBinMAX;
    incomeBinStepsPlusOne = incomeBinSteps;
    incomeBinStepsPlusOne(length(incomeBinStepsPlusOne)+1,1) = ...
        incomeBinSteps(length(incomeBinSteps))+incomeBin;
    incomeBinStepsString = {'zero','five','ten','fifteen','twenty',...
        'twentifive','thirty','thirtyfive','forty','fortyfive','fifty',...
        'fiftyfive','sixty','sixtyfive','seventy','seventyfive'...
        'eighty','eightyfive','ninety','ninetyfive','hundred'};

    %delete rows above maxIncomeAccepted
    idx = incomeBinSteps > maxIncomeAccepted;
    % store deleted rows
    m_toDelete = incomeBinSteps(idx,:);
    % delete rows
    incomeBinSteps(idx,:) = [];
    idx = [];
    m_toDelete = [];
    
    incomeBinStepsString = incomeBinStepsString';
    
    walkingTimeArray = table2array(walkingTime);
    
    for j = 1:length(incomeBinSteps)
        walkingTimeGroup.(incomeBinStepsString{j}) = ...
            walkingTimeArray(any(walkingTimeArray == incomeBinSteps(j),2),:);
        walkingTimeGroup.(incomeBinStepsString{j}) = ...
            sortrows(walkingTimeGroup.(incomeBinStepsString{j}),5);
        walkingTimeGroup.(incomeBinStepsString{j}) = walkingTimeGroup.(incomeBinStepsString{j})(:,5)/60;
%         idx = walkingTimeGroup.(incomeBinStepsString{j}) > maxIncomeAccepted;
%         % store deleted rows
%         m_toDelete = walkingTimeGroup.(incomeBinStepsString{j})(idx,:);
%         % delete rows
%         walkingTimeGroup.(incomeBinStepsString{j})(idx,:) = [];
    end
    
    saveWTG.(sim{i}) = walkingTimeGroup;
end

for k = 2:length(sim)
    if DemandProfilePlot == 1
        tiledlayout(TL1,TL2)
        for j = 1:length(incomeBinSteps)
            nexttile
            for i = couple.(sim{k})   %1:length(sim)
                histogram(saveWTG.(sim{i}).(incomeBinStepsString{j}),'Normalization',...
                    'cdf','BinWidth',1,'EdgeAlpha',0.1,...
                    'FaceColor',colorHist(i,:),'FaceAlpha',0.2);
                if isnan(mean(saveWTG.(sim{i}).(incomeBinStepsString{j}))) == 0
                    xline(mean(saveWTG.(sim{i}).(incomeBinStepsString{j})),':','Color',...
                    colorHist(i,:),'LineWidth',2);
                else
                    continue
                end
                hold on
                ylim([0 1]);
                xlabel('Walking Time [min]');
                titlePlot = [];
                titlePlot.a = sprintf('From ');
                titlePlot.b = sprintf(' %s',string(incomeBinStepsPlusOne(j)));
                titlePlot.c = sprintf(' To ');
                titlePlot.d = sprintf(' %s',string(incomeBinStepsPlusOne(j+1)));
                titlePlot.e = sprintf(' €/h');
                titlePlotAll = strcat(titlePlot.a,titlePlot.b,titlePlot.c,...
                    titlePlot.d,titlePlot.e);
                title(titlePlotAll);
                
                %control this
            end
        end
        lg = legend(string(sim{1}),string(simAVG{1}),string(sim{k}),...
        string(simAVG{k}));
        lg.Layout.Tile = 'east';
    
        filename = [];
        filename.a = sprintf('Cumulative Distribution Walking Time_');
        filename.b = whichLoop;
        filename.c = sprintf('_%s',string(sim(couple.(sim{k}))));
        filename.d = sprintf('.png');
        filename = strcat(filename.a,filename.b,filename.c,filename.d);
        saveas(gca,filename);
    end
    close
end

% Delete useless variables
clear walkingTime;
clear walkingTimeIncomeBin;
clear walkingTimeIncomeBinMin;
clear walkingTimeIncomeBinMAX;
clear saveWTG;
clear couple010;
clear couple030;
clear couple105;
clear couple120;