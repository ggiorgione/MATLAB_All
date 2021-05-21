function [d1,d2] = funPlot(type,varargin)
% The following function provides users to eligantly display data with ease
% and still be able to encapsilate the complexity of an eligant design.
% the methods include:
% -------------------------------------------------------------------------
% 'bar' - Display bargraph, with string ticks, alpha shading and more
% Inputs: Data, Ticks, handles
% Outputs: figure structure
% Handles - 'fig': #, 'axis': 'norm' | 'zero', 'ang': #, 'split': DNE yet
% -------------------------------------------------------------------------
% 'barh' - horizontal bargraph, with string ticks, alpha shading and more
% Inputs: Data, Ticks, handles
% Outputs: figure structure
% Handles - 'fig': #, 'axis': 'norm' | 'zero', 'ang': #, 'split': DNE yet
% -------------------------------------------------------------------------
 % 'fill' - fill in line graph
% Inputs: {x,up,low} | {x,up,low}
% Output: handle, message
% Handles: 'color': 'b','edge': 'b', 'add': 1, 'transparency': .5
% -------------------------------------------------------------------------
% 'date' - plots time series data
% Inputs: X, Y
% Handles: 'title': [], 'xlabel': [], 'ylabel': [], 'axis': 'tight'
% -------------------------------------------------------------------------
% 'color' - gets the vector to quality and complex colors
% Inputs: Number | color name
% Output: color vector
% -------------------------------------------------------------------------

switch type
    case 'bar',     d1 = advBarPlt(varargin{:});
    case 'barh',    d1 = advBarhPlt(varargin{:});
    case 'scatter', scatterColorMap(varargin{:});
    case 'date', plotTimeData(varargin{:});    
    case 'fill', [d1,d2] = fillPlot(varargin{:});
    case 'txt',  PlotColorText(varargin{:});
             
    case 'cycle', plotCycleCircle(varargin{:});
    case 'vec',  CycleVector(varargin{:});
        
    case 'color', d1 = GCNType(varargin{:});   
    case 'fade',  d1 = ColorMapFade(varargin{:});
end


end


% Fill Plot:
function [fillhandle,msg] = fillPlot(varargin)
% John A. Bockstege November 2006
%fillhandle is the returned handle to the filled region in the plot.
%
% Inputs:
%xpoints= The horizontal data points (ie frequencies). Note length(Upper)
%         must equal Length(lower)and must equal length(xpoints)!
%upper = the upper curve values (data can be less than lower)
%lower = the lower curve values (data can be more than upper)
%color = the color of the filled area 
%edge  = the color around the edge of the filled area
%add   = a flag to add to the current plot or make a new one.

tL = length(varargin);
WM = {'color','edge','add','transparency'};
WN = {[.85 .33 .1],[.85 .33 .1],1,.5};

if rem(tL,2), s = inputMethods('adv',WM,WN,{'x','up','low'},varargin); else
    s = inputMethods('adv',WM,WN,{'up','low'},varargin);
    s.x = zeros(size(s.up));
end

if s.add, hold on, end
if length(s.up)~= length(s.low) || length(s.low)~= length(s.x)
    msg='Error: Must use the same number of points in each vector'; return
end


msg='';
filled = [s.up,s.fliplr(s.low)];
s.x    = [s.x,s.fliplr(s.x)];
fillhandle=fill(s.x,filled,s.color);%plot the data
set(fillhandle,'EdgeColor',edge,...
               'FaceAlpha',transparency,...
               'EdgeAlpha',transparency);

end


% Plot time series data:
function plotTimeData(varargin)

WN = {[],[],[],'tight'};
WM = {'title','xlabel','ylabel','axis'};
s = inputMethods('adv',WM,WN,{'X','Y'},varargin);

if size(s.Y,1) ~= 1 && size(s.Y,2) ~= 1
      for i = 1:size(s.Y,2), plot(s.X,s.Y(:,i)), end
else, plot(s.X,s.Y) 
end


axis(s.axis) % set axis type
datetick('x','mmm'); % Draw Out X Ticks
if isempty(s.title), title(s.title), end
if isempty(s.xlabel), ylabel(YT),    end
if isempty(s.ylabel), ylabel(YT),    end


end


% scatter plot function
function scatterColorMap(varargin)
% Case 1: weight vector val is provided
% Case 2: weight vector val is not provided

tL = length(varargin); c1 = [.85 .33 .1]; c2 = [0,.45,.74];
WM = {'type','mp','lim','c1','c2','size','filled','gmaps','maptype'};
WN = {'std',1,3,c1,c2,25,'on','off','roadmap'};

if rem(tL,2), s = inputMethods('adv',WM,WN,{'x','y','val'},varargin);
    % Case 1: weight vector val is provided
    C = ColorMapFade(s.val,s.type,s.lim,s.mp);
    
    I = (sum(isnan(C),2)== 0); C = C(I,:);
    s.x = s.x(I,:); s.y = s.y(I,:);
else
    % Case 2: weight vector val is not provided
    s = inputMethods('adv',WM,WN,{'x','y'},varargin); C = s.c2;
end

% Scatter Plot data on figure
if strcmpi(s.filled,'on'), scatter(s.x,s.y,s.size,C,'filled')
else,scatter(s.x,s.y,s.size,C) % Upload optional google plot
end,if strcmpi(s.gmaps,'on'), plot_google_map('maptype','roadmap'); end

end


% advanced bar plot
function b = advBarPlt(varargin)
% Plot Bar Graph With 2 data vectors
WM = {'fig','axis','ang','split'}; WN = {[],[],45,[]};
s = inputMethods('adv',WM,WN,{'d','ticks'},varargin);
if isempty(s.fig) == 0, figure(s.fig), end
x = 1:size(s.d,1);  L = size(s.d,2);

Color1 = GCNType(1);       b = bar(x,s.d);
b(1).FaceColor = Color1;   b(1).FaceAlpha = 0.2;
b(1).EdgeColor = Color1;   b(1).LineWidth = 2;
for i = 2:L, Color2 = GCNType(i);
    b(i).FaceColor = Color2;  b(i).FaceAlpha = 0.2;
    b(i).EdgeColor = Color2;  b(i).LineWidth = 2;
end

if isempty(s.ticks) == 0
    xticklabels('manual');       set(gca,'XTick',x);
    xticklabels(s.ticks);        xtickangle(s.ang);
end

if isempty(s.axis) == 0
    switch s.axis
        case 'norm', axis([0,length(s.d),min(s.d),max(s.d)])
        case 'zero', axis([0,length(s.d),0,max(s.d)])
    end
end

end


% advanced horizontal bar plot
function b = advBarhPlt(varargin)
% Plot Bar Graph With 2 data vectors
WM = {'fig','axis','ang','split'}; WN = {[],[],0,[]};
s = inputMethods('adv',WM,WN,{'d','ticks'},varargin);
if isempty(s.fig) == 0, figure(s.fig), end
x = 1:size(s.d,1);  L = size(s.d,2);

Color1 = GCNType(1);       b = barh(x,s.d);
b(1).FaceColor = Color1;   b(1).FaceAlpha = 0.2;
b(1).EdgeColor = Color1;   b(1).LineWidth = 2;

for i = 2:L, Color2 = GCNType(i);
    b(i).FaceColor = Color2;  b(i).FaceAlpha = 0.2;
    b(i).EdgeColor = Color2;  b(i).LineWidth = 2;
end

if isempty(s.ticks) == 0
    yticklabels('manual');       set(gca,'YTick',x);
    yticklabels(s.ticks);        ytickangle(s.ang);
end

if isempty(s.axis) == 0
    switch s.axis
        case 'norm', axis([0,length(s.d),min(s.d),max(s.d)])
        case 'zero', axis([0,length(s.d),0,max(s.d)])
    end
end

end


% plot colored text
function PlotColorText(varargin)
% X location    Y Location     V Color
%
% Future can add color

WN = {'color','split','type','val','FontSize'};
WM = {[GCNType(1);GCNType(2)],'off','double',0,7};
s = inputMethods('adv',WN,WM,{'x','y','v'},varargin);

if isNumber(s.v(1))
    if strcmpi(s.split,'on'), s.idx = {find(s.v >= 0),find(s.v < 0)}; else
        s.idx = {(1:length(s.x))'};
    end,s.v = value2string(s.v,s.type,'cell');
end

for i = 1:length(s.idx)
        text(s.x(s.idx{i}),s.y(s.idx{i}),s.v(s.idx{i}),...
        'FontSize',s.FontSize,...
        'horizontal','left',...
        'vertical','top',...
        'Color',s.color(i,:),...
        'FontWeight','bold');
end

end


% plot cycle vector
function CycleVector(varargin)
% Plots a circular cycle of some given circle in 2D animation, x is your x
% vector for your circle. y is your y vector for your circle, and time is
% the amount of time between graphical printout.

WN = {'title'}; WM = {'Vector Plot'};
s = inputMethods('adv',WN,WM,{'Vector','Cycle'},varargin);


if isempty(s.Cycle) == 0, plot(s.Cycle(:,1),s.Cycle(:,2)), end
TS =size(s.Vector);

if TS(1) == 1 && TS(2) == 2 % If vector is a True Vector:
    X = [0;s.Vector(1)]; Y = [0;s.Vector(2)]; s.Vector = [X Y];
end


if nargin == 2, hold on, 
    plot(s.Vector(:,1),s.Vector(:,2)), hold off
end

end


% Plot animated cycle vector
function plotCycleCircle(varargin)
% Plots a circular cycle of some given circle in 2D animation, x is your x
% vector for your circle. y is your y vector for your circle, and time is
% the amount of time between graphical printout.

WN = {'time','Title'}; WM = {.00001,'Circle Vector Animation'};
s = inputMethods('adv',WN,WM,{'x','y','time','Title'},varargin);


for i = 1:length(s.x)
    plot(s.x,s.y), hold on, X = [0;s.x(i)]; Y = [0;s.y(i)];
    plot(X,Y), title(s.Title), drawnow(), pause(s.time), hold off
end


end


% get interesting colors.
function c = GCNType(type)

switch type
    case {'blue',1}, c = [0.0 0.45 0.74];
    case {'orange',2}, c = [0.85 0.33 0.1];
    case {'grey',3}, c = [.5 .5 .5];
    case {'yellow',4},  c = [0.929 0.694 0.125];
    otherwise,  c = [0.0 0.45 0.74];
end
end


% color map fade function
function d1 = ColorMapFade(varargin)
% red is low percent rank, blue is higher percent rank
WM = {'type','lim','mp'}; WN = {'std',3,1};
s  = inputMethods('adv',WM,WN,{'val','type','lim','mp'},varargin);
d1 = zeros(length(s.val),3);

switch s.type
    case 'rank',s.val = tiedrank(s.val)./length(s.val); Weight = 1;
    case 'point', Weight = s.val;
    case 'std', Mean = nanmean(s.val); Std = nanstd(s.val);
                sft = (s.val - Mean)./Std; s.val(sft > s.lim) = s.lim; 
                s.val(sft < -1*s.lim) = -1*s.lim;
                Weight = (s.val - min(s.val))./(max(s.val)- min(s.val));
end

c1w = s.mp - s.c1;
c2w = s.mp - s.c2; 

if strcmpi(s.type,'point'), mW = 0; else, mW = nanmean(Weight); end
if sum(Weight < mW) ~= 0
    d1(Weight < mW,:) = s.c1 + c1w.*(1 - abs(Weight((Weight < mW))));
end

if sum(Weight >= mW) ~= 0
    d1(Weight > mW,:) = s.c2 + c2w.*(1 - Weight((Weight > mW)));
end

end

