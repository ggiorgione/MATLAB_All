function [d1,d2,d3,d4] = factorMethods(type,varargin)
% Factor methods covers the application of factor analysis on data sets. as
% well as various plot methods.
% -------------------------------------------------------------------------
% 'gen' - generate factor analysis high dim. embedding
% inputs:  data, dim, variables, feild names, name
% outputs: data structure, data analysis object
% -------------------------------------------------------------------------
% 'get' - transform data via structure
% inputs:  data, variable feilds, structure, name of structure
% outputs: data, new names, data analysis object, variables
% -------------------------------------------------------------------------
% 'plot' - displays visualization for both 2 and 3 dim. factors
% inputs: structure, name of structure
% Outputs: (None)
% -------------------------------------------------------------------------
% 'plot' - visualization of factor importance
% inputs: structure, name of structure and handles
% Outputs: (None)
% -------------------------------------------------------------------------
% 'disp' - displays the corrilation coefficent matrix and loglike value
% Inputs:  structure, name of structure and handles
% Outputs: (None)
% -------------------------------------------------------------------------
% 'lgc' - boolean value which determines if the struct is factorian
% Inputs:  factorian Structure
% Outputs: Boolean value
% -------------------------------------------------------------------------

switch type
    case 'gen', d1 = setfactoranCell(varargin{:});
    case 'lgc', d1 = isFactorStruct(varargin{:});
    case 'get', [d1,d2,d3,d4] = getScores(varargin{:});
    case 'plot', plotFactorianData(varargin{:});
    case 'disp', dispFactorianData(varargin{:});
    case 'bar', barPlotFactorian(varargin{:})
end


end

% generate factor analysis transformation:
function data = setfactoranCell(varargin)

s  = inputMethods('basic',{'vbl','data','m','fld','nme'},varargin);
s.data = s.data(all(~isnan(s.data),2),:); 

if ~isempty(s.nme), s.nme = char(cellstr(s.nme)); end
if isempty(s.fld), [Lbda,Psi,T,stats,F] = factoran(s.data,s.m); else
     [Lbda,Psi,T,stats,F] = factoran(s.data,s.m,s.fld{:});
end

if isempty(s.fld), score_type = 'wls'; else % get factorian type
    scoresNames = {'bartlett','wls','thomson','regression'};
    Logics = ismember(s.fld,scoresNames);
    if sum(Logics) ~= 0, score_type = feilds(Logics); else
        score_type = 'wls';
    end
end

for i = 1:s.m % load new names
    if i == 1
        NNames = strcat(s.nme,{'_'},val2str(i,'number','cell'));
    else
        NNames(i) = strcat(s.nme,{'_'},val2str(i,'number','cell'));
    end
end


% generate structure
stats.Lambda = Lbda; stats.Psi = Psi; stats.T = T;
stats.score_type = score_type; stats.dim_m = s.m;
stats.Variables = s.vbl; stats.New_Variables = NNames;
stats.Mean = mean(s.data); stats.Std = std(s.data); 
stats.Var = var(s.data); stats.name = s.nme;
data = stats;

end


% get factorian scores
function [F,NNames,DAObj,vbls] = getScores(varargin)


s  = inputMethods('safe',{'strct','data','vbl','nme'},varargin);
if isFactorStruct(s.strct) == 0
    s.strct = s.strct.(charFormat(s.nme));
end % end of initial input processing


I = getIndex(s.vbl,s.strct.Variables,'delete'); % organize data such that
s.vbl = s.vbl(I); s.data = s.data(:,I);         % it matches intial data


X = (s.data - s.strct.Mean)./s.strct.Std; % zero mean and unit 
n = size(X,1); m = s.strct.dim_m;         % unit variance data


if length(s.vbl) ~= length(s.strct.Variables) % ensure all data is present  
   error('incorrect variable entry')          % with new input data
end

sqrtPsi = sqrt(s.strct.Psi); isrtPsi = diag(1 ./ sqrtPsi);
switch charFormat(s.strct.score_type) % process score type
    case {'wls', 'bartlett'}
        F = (X*isrtPsi) / (s.strct.Lambda'*isrtPsi);
        
    case {'regression', 'thomson'}
        F = [X*isrtPsi zeros(n,m)] / [s.strct.Lambda'*isrtPsi s.strct.T'];
        
end,

NNames = s.strct.New_Variables;


if sum(F(all(isinf(F),2),:))~= 0
    disp('infinities were replaced with nans: Factor Analysis')
end

DAObj = s.strct.dao; vbls = s.strct.Variables;
F(all(isinf(F),2),:) = NaN;

end


% is factor structure
function Lgcl = isFactorStruct(data)

if isstruct(data) == 0, Lgcl = false; return, end
inpts = {'loglike','dfe','chisq','p','Lambda','T','score_type','dim_m',...
    'Variables','New_Variables','Mean','Std','Var','name'};
flnms = fieldnames(data); Lgcl = sum(ismember(flnms,inpts));
Lgcl = Lgcl > 10;


end


% plot visualization
function plotFactorianData(varargin)

NW = {'name','fig'}; MW = {[],[]}; % pre-processing inputs
s  = inputMethods('asafe',NW,MW,{'strct'},varargin);
if isFactorStruct(s.strct) == 0
    s.strct = s.strct.(charFormat(s.nme));
end % end of initial input processing
if isempty(s.fig), figure(); else, figure(s.fig); end


invT = inv(s.strct.T);
Lambda0 = s.strct.Lambda/s.strct.T;
grid on, hold on
biplot(Lambda0,'LineWidth',2,'MarkerSize',20)
xlabel('Loadings for unrotated Factor 1'),title('Factor Analysis')
ylabel('Loadings for unrotated Factor 2'), hold off;
if length(invT) == 2
    line([-invT(1,1) invT(1,1) NaN -invT(2,1) invT(2,1)], ...
        [-invT(1,2) invT(1,2) NaN -invT(2,2) invT(2,2)], ...
        'Color','r','linewidth',2)
elseif length(invT) == 3
    line([-invT(1,1) invT(1,1) NaN  -invT(2,1) invT(2,1) NaN...
        -invT(3,1) invT(3,1)],[-invT(1,2) invT(1,2) NaN  -invT(2,2)...
        invT(2,2) NaN  -invT(3,2) invT(3,2)],[-invT(1,3) invT(1,3)...
        NaN  -invT(2,3) invT(2,3) NaN  -invT(3,3) invT(3,3)],...
        'Color','r','linewidth',2)
    zlabel('Loadings for unrotated Factor 3')
end


end


% bar plot factorian
function barPlotFactorian(varargin)

NW = {'name','fig','type','graph'}; MW = {[],[],[],'barh'}; % ipt settings
s  = inputMethods('asafe',NW,MW,{'strct'},varargin);
if isempty(s.fig), figure(); else, figure(s.fig); end

data = s.strct.Lambda; Vbls = s.strct.Variables;

if isempty(s.type) == 0
    switch s.type
        case 'mag', data = funMth('mag',data);
    end
end

funPlot(s.graph,data,Vbls);

end


% display Factorian Data
function dispFactorianData(varargin)

NW = {'name'}; MW = {[]}; % pre-processing inputs
s  = inputMethods('asafe',NW,MW,{'strct'},varargin);
if isFactorStruct(s.strct) == 0
    s.strct = s.strct.(charFormat(s.nme));
end % end of initial input processing

disp('corrilation Matrix')
disp(s.strct.Lambda/(Fstruct.T'*Fstruct.T)...
    *s.strct.Lambda'+diag(Fstruct.Psi)) 
fprintf('loglike value: %f \n',s.strct.loglike)

end