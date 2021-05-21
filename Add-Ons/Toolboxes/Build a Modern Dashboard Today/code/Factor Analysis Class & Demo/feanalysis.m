classdef feanalysis
    % feanalysis - Factor Exploratory Analysis
    % Used to generate laten variables and which shows the linear
    % relationship with other data.
    % 
    %
    % Personal Notes: F'\(isrtPsi/(O.Lambda'*isrtPsi))';
  
    % general properties:        
    properties
        
        
        Tag     % tag name for feanalysis object
        Lambda  % maximum likelihood estimate
        Psi     % maximum likelihood estimates variances
        Score            % numerical method used
        Dimensions       % new feature space dimension
        Variables        % old variables
        LatentVariables  % New variables
        Stats;           % statistics
        T                % Rotation matrix
        
        Mean % mean of original data set
        Std  % std of original data set 
        Var  % var of original data set
        
        
    end
    
    
    % general methods:
    methods
        
        
        % train constructor
        function obj = feanalysis(data,varargin)
            
            
            names = {'vbl','m','fields','tag'};
            
            
            % upload data to a structure:
            if istable(data) % if data is a table extract names:
                vbls = data.Properties.VariableNames;
                data = table2array(data);
                s = inputMethods('basic',names,[{vbls},varargin]);
                
            else % if just an array
                s = inputMethods('basic',names,varargin);
                
            end
            
            if ~isempty(s.tag), s.Tag = char(cellstr(s.tag)); end
            Nms = cell(1,s.m); % preallocate memory and load fields
            
            for i = 1:s.m % load new names
                Nms{i} = strcat(s.tag,{'_'},{num2str(i)});
            end
            
            
            % define the score used:
            if isempty(s.fields) 
                score_type = 'wls'; 
            
            else % figure out the score used if any
                scoresNames = {'bartlett','wls','thomson','regression'};
                LogicVector = ismember(s.fields,scoresNames);
                
                if sum(LogicVector) ~= 0 
                    score_type = feilds(LogicVector); 
                else
                    score_type = 'wls';
                end
            end
            
            
            % clean data of all nans:
            data = data(all(~isnan(data),2),:);
            obj.Mean = mean(data);
            obj.Std = std(data);
            obj.Var = var(data);
            
            
            if isempty(s.fields) 
                [Lbda,Psi,T,stats] = factoran(data,s.m); 
            else
                [Lbda,Psi,T,stats] = factoran(data,s.m,s.fields{:});
            end

            clear data % clear data before duplicating more data
            % compile structure with the rest of the variables
            obj.Lambda = Lbda;
            obj.Psi = Psi;
            obj.T = T;
            obj.Score = score_type;
            obj.Dimensions = s.m;
            obj.Variables = s.vbl; 
            obj.LatentVariables = Nms;
            obj.Stats = stats;
            obj.Tag   = s.tag;
  
        end
        
        
        % get factorian scores
        function [F,NNames,vbls] = encode(O,data,vbls)
            
            
            % upload data to a structure:
            if istable(data) % if data is a table extract names:
                vbls = data.Properties.VariableNames;
                data = table2array(data);
                
            elseif nargin < 3 % check if variables were sent
                error('obj,data, and varible names are required')
                
            end
            
            % organize data such that it matches the original data:
            [~,I] = ismember(O.Variables,vbls);
            
            if any(I == 0)
               error('Not all original variables are present') 
            end

            data = data(:,I); % match the original
            
            
            X = (data - O.Mean)./O.Std;   % std zero unit mean
            n = size(X,1); m = O.Dimensions; % unit variance data

            
            sqrtPsi = sqrt(O.Psi); 
            isrtPsi = diag(1 ./ sqrtPsi);
            
            switch char(O.Score) % process score type
                case {'wls', 'bartlett'}
                    F = (X*isrtPsi)/(O.Lambda'*isrtPsi);
                    
                case {'regression', 'thomson'}
                    F = [X*isrtPsi,zeros(n,m)]/[O.Lambda'*isrtPsi,O.T'];
                    
            end
            
            
            if sum(F(all(isinf(F),2),:))~= 0
                disp('infinities were replaced with nans: Factor Analysis')
            end
            
            NNames = O.LatentVariables;
            vbls   = O.Variables;
            F(all(isinf(F),2),:) = NaN;
            
        end
        
        
        % get factorian scores
        function barPlot(O,varargin)
            
            process = [{O.Variables},varargin];
            
            % Plot Bar Graph With 2 data vectors
            WM = {'type','fig','axis','ang','split'}; 
            WN = {'stacked',[],[],0,[]};
            s = inputMethods('adv',WM,WN,{'ticks'},process);
            
            
            switch s.type
                
                case 'stacked'
                    data = abs(O.Lambda); L = size(data,2);
                    alpha = .85; edgewth = 1;
                   
                case 'normal'
                    data = O.Lambda; L = size(data,2);
                    alpha = .5; edgewth = 1.5;
                    
                case 'mag'
                    data = funMth('mag',O.Lambda); L = 1;
                    alpha = .5; edgewth = 1.5;
                    
            end
            
            if strcmpi('stacked',s.type) || strcmpi('mag',s.type)
                [~,idx] = sort(sum(data,2));
                data = data(idx,:);  s.ticks = s.ticks(idx);
            end
            

            if isempty(s.fig) == 0, figure(s.fig), end
            x = 1:size(data,1);     Color1 = GCNType(1);
            
            if strcmpi('stacked',s.type)
                b = barh(x,data,'stacked');
            else
                 b = barh(x,data);
            end
            
            
            b(1).FaceColor = Color1;   b(1).FaceAlpha = alpha;
            b(1).EdgeColor = Color1;   b(1).LineWidth = edgewth;
            
            for i = 2:L, Color2 = GCNType(i);
                b(i).FaceColor = Color2;  b(i).FaceAlpha = alpha;
                b(i).EdgeColor = Color2;  b(i).LineWidth = edgewth;
            end
            
            if isempty(s.ticks) == 0
                yticklabels('manual'); set(gca,'YTick',x);
                yticklabels(s.ticks);  ytickangle(s.ang);
            end
            
            if isempty(s.axis) == 0
                switch s.axis
                    case 'norm', axis([0,length(s.d),min(s.d),max(s.d)])
                    case 'zero', axis([0,length(s.d),0,max(s.d)])
                end
            end
            
        end
        
        
        % get factorian scores
        function biPlot(O,color)
            
            if nargin == 1, color = 'r'; end
 
            invT = inv(O.T);
            Lambda0 = O.Lambda/O.T;
            
            grid on, hold on
            biplot(Lambda0,'LineWidth',2,'MarkerSize',20)
            title('Factor Analysis')
            xlabel('Loadings for unrotated Factor 1')
            ylabel('Loadings for unrotated Factor 2')
            hold off;
            
            if length(invT) == 2
                line([-invT(1,1) invT(1,1) NaN -invT(2,1) invT(2,1)], ...
                    [-invT(1,2) invT(1,2) NaN -invT(2,2) invT(2,2)], ...
                    'Color',color,'linewidth',2)
            elseif length(invT) == 3
                line([-invT(1,1),invT(1,1),NaN,-invT(2,1),invT(2,1),NaN...
                    -invT(3,1),invT(3,1)],[-invT(1,2),invT(1,2) NaN,...
                    -invT(2,2),invT(2,2),NaN,-invT(3,2),invT(3,2)],...
                    [-invT(1,3) invT(1,3),NaN,-invT(2,3),invT(2,3),...
                    NaN,-invT(3,3) invT(3,3)],'Color',color,'linewidth',2)
                zlabel('Loadings for unrotated Factor 3')
            else
                error('To many dimensions use barPlot instead')
            end


            
        end
        
        
        
    end
end




% get interesting colors.
function c = GCNType(type)

switch type
    case {'pink',0}, c = [219,10,91]./255;
    case {'blue',1}, c = [0.0 0.45 0.74];  
    case {'green',2}, c = ([38, 194, 129])./255;
    case {'oran',3}, c = ([242, 120, 75])./255;
    case {'grey',4}, c = [.5 .5 .5];
    case {'yellow',5},  c = [0.929 0.694 0.125];
    case {'orange',6}, c = [0.85 0.33 0.1];
    case {'teal',7}, c = ([134, 226, 213])./255;
    case {'purple',8}, c = ([155, 89, 182])./255;
    otherwise,  c = [rand rand rand];
        
end

end


