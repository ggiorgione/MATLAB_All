function [Data,O] = DataTrimming(type,varargin)
% If repeat numbers are present in the data structure they are removed and
% the changes are stored in the specified array.
%
% notes - advanced is prefered over standard
% -------------------------------------------------------------------------
% 'standard' returns data array with deleted elements - [value]
% input - Data | Data and j (index to analize)
% -------------------------------------------------------------------------
% 'advanced' returns array with mapped out indicies - [value, start, end]
% input - Data | Data and j (index to analize)
% -------------------------------------------------------------------------
% 'thresh' returns processed data after threshold has been applied
% inputs - data, thresh-type, thresh
% type: min, max, mid (filter type)
% -------------------------------------------------------------------------
% 'remap' - remap data to original specs - Data
% input: data - [value, start, end]
% -------------------------------------------------------------------------
% 'spline' - Splines data via remap process: (Pre-process with advanced)
% inputs:  date, data - [x-data y-data] | [value, start, end]
% outputs: interpulated data
%
% handles: 'type', 'process', 'plot', 'method', 'setting'
% 'Type': left, right, mid -- default (left)
% 'Process': for preform preprocessing function -- no default
% 'plot': binary value, 1 for plot 0 for no plot -- default (0)
% 'methods': 'csapi' for spline | 'pchip' or Piecewise Cubic Hermite 
%            Interpolating Polynomial.
%
% 'setting': 'fill' to fill in NaN's
% -------------------------------------------------------------------------
% 'feature' - For time series analysis feature extraction includes
%             derivatives for a wide varaty of data of maximum and minimum
%             boundaries.
% inputs: date vector, data vector
% outputs: data structure, and definition structure
% for handles refer to spline
% -------------------------------------------------------------------------
% 'replace' - enables user to replace data with a predefined value.
% inputs: (main - input data, val - isolation value, new - replace value)
% Outputs: reworked data, Index of reworked data.
% handles: 'filter', 'action', 'new'
% -------------------------------------------------------------------------

switch type
    case 'advanced', Data = AdvancedDataTrimming(varargin{:});
    case 'standard', Data = StandardDataTrimming(varargin{:});
    case 'thresh', [Data,O] = threshReplaceHandles(nargout,varargin{:});
    case 'remap', Data = remapDataTrimFun(varargin{:});
    case 'spline', [Data,O]  = remapData2Spline(nargout,varargin{:});
    case 'feature', [Data,O] = extractFeatures(nargout,varargin{:});
    case 'replace', [Data,O] = setVectorHandles(nargout,varargin{:});
end


end

% feature Extraction:
function [DOut,Deffs] = extractFeatures(numOut,varargin)
% inputs are either - case 1. Structure, case 2. date, data. 

s = inputMethods('basic',{'date','data'},varargin);       % check if needs
if size(s.data,2) ~= 3, s.data = AdvancedDataTrimming(s); % pre-processing
end, HasMinMax = true; YY = remapData2Spline(s); XX = (1:length(YY))';
if s.date(1) < s.date(2), DDiff = 'forwards'; else, DDiff = 'reverse'; end

% Calculate Thresholds of max and mins
try [MaxPk,MinPk,~] = peakMethods('advanced',XX,YY);
    [Y1,~] = DataTrimming('spline',XX,MaxPk,'setting','fill');
    [Y2,~] = DataTrimming('spline',XX,MinPk,'setting','fill');
    
    Y3 = ((Y1 - Y2)./2) + Y2; Y4 = (Y1 - Y2)./Y3;   
    Y1Diff = diffPlus(Y1,DDiff); Y2Diff = diffPlus(Y2,DDiff);
    Y3Diff = diffPlus(Y3,DDiff); catch, HasMinMax = false;
end, YYDiff = diffPlus(YY,DDiff); 


if numOut == 0, DataTmp = remapDataTrimFun(s.data); DOut = [];
    if HasMinMax == 1, figure(15), subplot(3,1,1); plot(YY)
        plot(Y1), plot(Y2), plot(Y3), hold off, subplot(3,1,2)
        plot(Y1Diff),hold on,plot(Y2Diff),plot(Y3Diff),hold off
        subplot(3,1,3), plot(Y4)
    end, figure(5), plot(YY), hold on, plot(DataTmp), Deffs = [];
    if HasMinMax == 1, plot(Y1), plot(Y2), plot(Y3), end, hold off, return
end, Deffs = getFeatureList;

if HasMinMax, DData = {YY,YYDiff,Y1,Y2,Y3,Y1Diff,Y2Diff,Y3Diff,Y4};
   NData = {'value','diff_value','high','low','mid','diff_high',...
            'diff_low','diff_mid','Delta'};
else, NData = {'value','diff_value'}; DData = {YY,YYDiff};
end, DOut = structMethods('set',[],NData,DData);


end


% replace threshold values:
function [d,I,Idx] = setVectorHandles(NumbOut,varargin)
% the following function is able to provide 2 main types of filters. the
% first, value will replace all data equal to val with the 'new'
% data-element. second, inverse will replace all data that is not of equal
% val and replace it with the 'new' data-element.

WM = {'filter','action','new'}; WN = {'value','process',0}; I = [];
s = inputMethods('adv',WM,WN,{'main','val','new'},varargin); 
if NumbOut == 0, s.action = 'display'; end, d = s.main;
if strcmpi(s.action,'original'), figure(23), plot(d), title('Filter') 
    ylabel('Independent Variable'),xlabel('Dependent Variable'), return
end,Idx = (1:length(s.main))';



if isnan(s.val), I = isnan(s.main); else, I = s.main == s.val; end
switch s.filter % filters that are able to be applied  Case #
    case 'value', Idx = Idx(I);
    case 'inverse', Idx = Idx(I == 0);   
end, s.main(Idx) = s.new; d = s.main;   

if strcmpi(s.action,'display'), plot(d),title('Filter')  
    ylabel('Independent Variable'), xlabel('Dependent Variable')
end

end


% replace threshold values:
function [d,I,Idx] = threshReplaceHandles(NumbOut,varargin)
% the following function is able to provide 4 main types of filters. value
% will delete data of a specific value. min is the minimum value. max is
% the maximum value. and mid is the acceptable range.

switch length(varargin) % upack varagain data 
    case 1, s = varargin{1}; 
    case 2, s = varargin{2}; s.('main') = varargin{1};
    case 4, s = inputMethods('basic',{'main'},varargin);    
    case 3, s = struct('main',varargin{1}); s.('filter') = varargin{2};
            s.(charFormat(varargin{2})) = varargin{3};
end, Idx = (1:length(s.main))'; Deflt = struct('action','process'); 
s = structMethods('join',Deflt,s,'all'); I = NaN;
if NumbOut == 0, s.action = 'display'; end, d = s.main;
if strcmpi(s.action,'original'), figure(23), plot(d), title('Filter') 
    ylabel('Independent Variable'),xlabel('Dependent Variable'), return
end
switch s.filter % filters that are able to be applied
    case 'value', I = s.main == s.value; Idx = Idx(I);
    case 'min',   I = s.main < s.min; Idx = Idx(I);   
    case 'max',   I = s.main > s.max; Idx = Idx(I);
    case 'mid',   I = s.main < s.min | s.main > s.max; Idx = Idx(I);  
end
for i = 1:length(Idx)
    if Idx(i) == 1, s.main(1) = s.main(2);
    else, s.main(Idx(i)) = s.main(Idx(i)-1);
    end
end, d = s.main;
if strcmpi(s.action,'display'), plot(d),title('Filter')  
    ylabel('Independent Variable'), xlabel('Dependent Variable')
end

end

% Remap Trimmed data:
function DataOut = remapDataTrimFun(varargin)

s = inputMethods('basic',{'main'},varargin); % Extract Data:
if size(s.main,2) ~= 3, DataOut = data; return
end, DataOut = NaN(s.main(end,3),1);
for i = 1:size(s.main,1), DataOut(s.main(i,2):s.main(i,3),1) = s.main(i,1);
end

end

% convert Trimmed data to spline:
function [YOut,XOut] = remapData2Spline(outNumb,varargin)
% This function interprets a variety of data inputs to best understand what
% the call is tying to solve for.
% first input must be either a structure or data
% general constants

if nargin == 1, varargin = outNumb; outNumb = nargout; end
NDefault = {'type','process','setting','plot','method'}; % default names
DDefault = {'left',[],'none',0,'csapi'}; % default values
s = inputMethods('adv',NDefault,DDefault,{'date','data'},varargin);
if isempty(s.process) == 0, s.data = DataTrimming(s.process,s.data); end
if size(s.data,2) == 3 % (Check if has been advanced process)
    % set up data output:min, Clean Data for (Left & Right)
    YOut = NaN(s.data(end,3),1); XOut = (1:s.data(end,3))';
    CData = s.data(isnan(s.data(:,1)) == 0,:); % rid all NaNs
    YL = [CData(:,1); CData(end,1)];  XL = [CData(:,2); CData(end,3)];
    YR = [CData(1,1); CData(:,1)];    XR = [CData(1,2); CData(:,3)];
    % set up all domain data & Interpulate
    XXL = (XL(1):XL(end))'; XXR = (XR(1):XR(end))'; % Generate domain
    switch s.method % csapi for spline, or pchip Piecewise Cubic
        case 'csapi', YL = csapi(XL,YL,XXL); YR = csapi(XR,YR,XXR); 
        case 'pchip', YL = pchip(XL,YL,XXL); YR = pchip(XR,YR,XXR);
        case 'interp1', YL = pchip(XL,YL,XXL); YR = pchip(XR,YR,XXR);
    end 
    switch s.type % exicute strucutre type
        case 'right', YOut(XXL) = YR;
        case 'left', YOut(XXL) = YL;
        case 'mid', Xspace = round(abs(XXL - XXR) + min(([XXL XXR]),[],2));
            MinVec = min(([YR YL]),[],2); Dirct = sign(MinVec);
            YOut(Xspace) = (Dirct.*abs(YR - YL)./2) + MinVec;
    end, else % (Raw data import) | set up all domain data & Interpulate
    XL  = s.data(:,1); XXL = (XL(1):XL(end))';
    Y   = s.data(:,2); YL  = csapi(XL,Y,XXL); % fill in data with NaN's
    if strcmpi('fill',s.setting), YOut = NaN(max(XL),1);
        XOut = (1:max(XL))'; YOut(XXL) = YL(1:end); else
        XOut = XXL; YOut = YL;
    end
end 

if outNumb == 0 || s.plot == 1 % plot figure
    figure(56), plot(XOut,YOut), plot(XOut),title('Data Interpulation Plot')
    ylabel('Independent Variable'), xlabel('Dependent Variable')
end



end


% isolate repeated values store indexes:
function DataOut = AdvancedDataTrimming(varargin)
% if size,2 data == 1, then j == 1 else j == 2
if isstruct(varargin{1}), D = varargin{1}.data; else, D = varargin{1}; end

if isstruct(D) % if struct
    [j,Logicl] = getStructData(D,'col'); % check if col is in struct
    D = D.data; % Nxt if col not pres | if two var assume [x y]
    if Logicl == 0, if size(D,2) == 1, j = 1; else, j = 2; end, end
else % if cell | if two variables assume [x y]
    if length(varargin) == 1, if size(D,2) == 1, j = 1; else, j = 2; end
    elseif length(varargin) == 2, D = varargin{1}; j = varargin{2};
    end
end, theSize = size(D); DataOut = [];
if size(D,2) == 3, DataOut = D; return, end

for i = 1:theSize(1)-1
    if i == 1, Left = 1; elseif D(i,j) ~= D(i+1,j)
        DataOut = joinRows(DataOut,[D(i,j) Left i]); Left = i + 1;
    elseif i == theSize(1)-1  
        DataOut = joinRows(DataOut,[D(i,j) Left theSize(1)]);
    end
end

end

% delete repeated values:
function Data = StandardDataTrimming(varargin)
% if size,2 data == 1, then j == 1 else j == 2

if length(varargin) == 1, Data = varargin{1};
    if size(Data,2) == 1, j = 1; else, j = 2; end 
elseif length(varargin) == 2, Data = varargin{1}; j = varargin{2}; 
end, k = 1; theSize = size(Data);

for i = 2:theSize(1),k = k + 1;
    if Data(k,j) == Data(k-1,j),k = k - 1; Data(k,:) = []; end
end

end


% get feature list:
function P1 = getFeatureList
P1 = struct('value',{'value interpolated value of '});
P1.('mid') = {'median interpolated value of '};
P1.('high') = {'interpolated ceiling value of '};
P1.('low') = {'interpolated floor value of '};
P1.('diff_high') = {'differentiated interpolated  ceiling value of '};
P1.('diff_low') = {'differentiated interpolated  floor value of '};
P1.('diff_mid') = {'differentiated interpolated median value of '};
P1.('Delta') = {'differentiation interpolated delta value of '};
P1.('diff_value') = {'differentiation interpolated value of '};
end

