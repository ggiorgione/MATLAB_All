function [d1,d2,d3,d4,d5,d6] = catMethods(type,varargin)
% The following method are usede to interact with the catigorical data like
% structure. The following functions can interact with a wide array of data
% including doubles as well. The following methods Include:
% -------------------------------------------------------------------------
% 'bin' - Processes variables into binary vector columns
% Inputs: raw (data, name), (data, name, cat) | (data, name, vec) | 
%         (data, name, vec, key)
% Outputs: Binary Array, Catigorical Names, Key
% -------------------------------------------------------------------------
% 'cnv' - short for convert, Allows user to translate one key to another
% Inputs: (data, main-key, new-key) |  (data, main-key, vec, cat)
% Outputs: translated data, Translate 2xn array
% -------------------------------------------------------------------------
% 'num' - processes catigorical data into vector arrays.
% Inputs: (data, cat) | (data, vec, key)
% Outputs: (numerical data vector, catiorical structure)
% -------------------------------------------------------------------------
% 'view' - articulates numerical boundary ranges of binary groupings
% Inputs: (name,key,vec,type)
% Outputs: Name cell strings
% -------------------------------------------------------------------------
% 'unique' - allocates bins to catigorical cell grouped numeric vectors
% Inputs - grouped numeric vector, number of avalible bins
% Outputs - bins allocated to grp vectors, pct of data per bin, unique data
% -------------------------------------------------------------------------
% 'pct' - retrieves percentage of unique data in group
% Inputs: raw data
% Output: unique data, percentage of unique data, length of data
% -------------------------------------------------------------------------
% 'gen' - generate a catigorical data
% Input: raw data
% Output: key, data, percent empty, percent nan, catigorical type
% -------------------------------------------------------------------------
% 'bar' - displays catigorical information
% Inputs: raw data, catigorcal key
% -------------------------------------------------------------------------

d1 = []; d2 = []; d3 = []; d4 = []; d5 = [];
switch type
    case 'bin', [d1,d2,d3] = any2binVcs(varargin{:});
    case 'cnv', [d1,d2] = catConvertFun(varargin{:});
    case 'num', [d1,d2] = cat2numb(varargin{:});
    case 'view', d1 = key2view(varargin{:});
    case 'grp', d1 = strNnums2grp(varargin{:});
    case 'unique', [d1,d2,d3] = uqeGrp(varargin{:});
    case 'pct', [d1,d2,d3] = uqePct(varargin{:});
    case 'gen', [d1,d2,d3,d4,d5,d6] = genCatKey(varargin{:});  
    case 'bar', d1 = catigorical2bar(varargin{:});
    case 'cpct', [d1,d2] = pctCInside(varargin{:});
    case 'iso', [d1,d2,d3] = isolateData(varargin{:});
end



end

% Isolate Data based on Key values:
function [Collect,Fields,Idx] = isolateData(varargin)

s = inputMethods('safe',{'key','cat','data','field'},varargin);
if isempty(s.field), s.field = 'undefined'; end

Collect = cell(length(s.key.vec),1);
Fields  = cell(length(s.key.vec),1);
Idx     = cell(length(s.key.vec),1);
Vec     = (1:length(s.cat))';

for i = 1:length(s.key.vec)
    Collect{i} = s.data(s.cat == s.key.vec(i));
    Fields{i}  = [s.key.key{i},', ',char(s.field)];
    Idx{i}     = Vec(s.cat == s.key.vec(i));
end


end

% raw data vector -> binary array
function [d,nmes,Key,I,T] = any2binVcs(varargin)
% Processes variables into binary vector columns derived from either a
% 1. key, 2. raw data or 3. key components, and lastly 4. (numeric) Keys.
% The function is able to utalize both raw data, a key, a key vec with or 
% without a catigorical data
% Note: catigorical data input is optional. If the catigorical data is not
% present the numeric values will be translated in strings which become the
% catigories.

NW = {'cat'}; MW = {[]}; % pre-processing inputs
s = inputMethods('asafe',NW,MW,{'data','name','vec','key'},varargin);
if isstruct(s.vec); s.cat = s.vec; s.vec = s.cat.vec; s.key = s.cat.key;
elseif isempty(s.vec), s.vec = unique(s.data); % clean vec of nans
s.vec = s.vec(all(~isnan(s.vec),2),:);
elseif  isempty(s.key) == 0, s.cat = struct('key',[]);
 s.cat.key = s.key; s.cat.('vec') = s.vec;
end

if isNumber(s.data) == 0, s.data = cat2numb(s.data,s.cat); end
s.data = alwaysCol(s.data); nmes = []; d = []; % pre-settings

if structMethods('lgc',s.cat,'keys'), K = s.cat.keys;
    V = s.cat.vec; L = length(V);  d = zeros(length(s.data),L); 
    for i = 1:L
        switch charFormat(K(i))
            case {'=='} % is equal too
                d(:,i) = double(s.data == V{i});
            case {'-'} % is range of
                d(:,i) = double(s.data >= min(V{i}) & s.data <= max(V{i}));
        end,newName = key2view(s.name,char(K(i)),V{i},'cell');
        nmes = joinRows(nmes,newName);
    end, d(all(isnan(s.data),2),:) = NaN; Key = s.cat;
    I = (sum(d,2) == 1) | isnan(s.data); T = I == 0; return
end, Key = struct('key',[]); L = length(s.vec);



for i = 1:L, d = joinColumns(d,double(s.data == s.vec(i))); end
d(all(isnan(s.data),2),:) = NaN; % set all nan-data
if isempty(s.cat) == 0
    for i = 1:length(s.key)
        nmes = joinColumns(nmes,strcat(s.name,{'_'},s.key(i)));
    end,else
    for i = 1:L,str = value2string(s.vec(i),'number','cell'); 
        nmes = joinColumns(nmes,strcat(s.name,{'_'},str));
    end
end,Key.('vec') = alwaysRow(s.vec);  Key.('key') = alwaysRow(nmes);
I = (sum(d,2) == 1) | isnan(s.data); T = I == 0;

end


% catigorical converter
function [d,Kd] = catConvertFun(varargin)
% Allows user to translate one key to another such that the new key. If you
% run a model on your main key. Update your data and run again. the New key
% generated needs to translated to the original main key. The main data
% must be a catigorical structure, the new can be either a 
% example: 
% main: [great = 1, good = 2, bad = 3];
% new:  [great = 1, good = 2, okay = 3, bad = 4];
% Translate new -> main
% great = 1 -> 1 = great, good = 2 -> 2 = good, okay = 3 -> DNE in main
% bad = 4 -> 3 = bad


s = inputMethods('safe',{'data','main','new','cat'},varargin);
if isempty(s.cat) == 0 && isstruct(s.vec) == 0 % set up new catigorical
    s.new = struct('vec',s.new); s.new.('key') = s.cat; %     structure
end, TrnsFrm = []; % generate a column of all strcells 'NaN'

for i = 1:length(s.new.vec),I = ismember(s.main.key,cellstr(s.new.key(i)));
    if sum(I) ~= 0, Val = s.main.vec(I); Kd = [Val s.new.vec(i)];
        s.data(s.data == Kd(2)) =  Val; TrnsFrm = joinRows(TrnsFrm,Kd);
    end
end,d = s.data;

end


% Catigorical -> Numerical vector
function [d,catKey] = cat2numb(varargin)
% processes catigorical data into vector arrays.
% Inputs: (data, cat) | (data, vec, key)
% Outputs: (numerical data vector, catiorical structure)
NW = {'cat'}; MW = {[]};
s = inputMethods('asafe',NW,MW,{'data','vec','key'},varargin);
if isstruct(s.vec), s.cat = s.vec; elseif isempty(s.key) == 0
    s.cat = struct('vec',[]);s.cat.vec = s.vec;s.cat.('key') = s.key; else
    error('invalid catigorical key input')
end,catKey = s.cat;

if structMethods('lgc',s.cat,'keys') == 0
    d = NaN(length(s.data),1);
    for i = 1:length(s.cat.key)
        d(ismember(s.data,cellstr(s.cat.key(i)))) = s.cat.vec(i);
    end, return
end

end


% creates groups from data
function Key = strNnums2grp(varargin)
% convert str string to a key
% inputs: str vector with defining how to bin up data, which is a numerical
% vector, and n are the number of subsections you wish to split the data up
% into. n can as well be defined in the syntax of the input

% pre-process data:
s = inputMethods('basic',{'data','str','n'},varargin);
Sol = []; RBnd = []; s.data = s.data(all(~isnan(s.data),2),:); % del nans
s.data = sortrows(s.data); s.data = {s.data}; % srt data then cell

if isNumber(s.str), if isempty(s.n), s.n = s.str; s.str = []; end
elseif isempty(s.str) == 0, s.str = cellstr(s.str); % process inputs
    if length(stringHandler(s.str,'|','split')) == 2
        strSplit = stringHandler(s.str,'|','split'); s.str = strSplit(1);
        s.n = str2double(stringHandler(strSplit(2),' ','split'));
    end,s.str = stringHandler(s.str,' ','split'); % split based on spaces
    if strcmpi(s.str(1),'|'), s.n = str2double(s.str(2)); else
        for i = 1:length(s.str) % spit string based on 'character'
            num = str2double(stringHandler(s.str(i),'-','split'));
            for j = 1:length(s.data), tmp = s.data{1}; s.data(1) = [];
                if length(num) == 1
                    if sum(tmp == num) == 0
                        s.data = joinColumns(s.data,{tmp});  continue 
                    end % RBound is the logical space, Sol is the Iso
                else     % data OtherData is the unused data.
                    if sum(tmp > num(1) & tmp < num(2)) == 0
                        s.data = joinColumns(s.data,{tmp});  continue
                    end
                end
                [tmp,uqe] = numMethods('lgc',tmp,num,'process','grp');
                Sol = joinRows(Sol,{cell2mat(tmp(uqe == 1)),num});
                RBnd   = joinRows(RBnd,{num}); OData = tmp(uqe ~= 1);
                s.data = joinColumns(s.data,OData); break
            end % Build Cell Bins, Large granularity
        end
    end
end

if isempty(s.n) == 0
    [~,Bins] = pctCInside(s.data,s.n); % build small bins
    for i = 1:length(Bins), grp = uqeGrp(s.data{i},Bins(i));
        for j = 1:size(grp,1), RBnd = joinRows(RBnd,{grp(j,:)}); end
    end
end

TVec = []; TKey = []; Tpks = []; % Build Key:
for i = 1:size(RBnd,1),DCell = RBnd{i}; % process data into key
    if length(DCell) == 2
        if DCell(1) == DCell(2), TKey = joinRows(TKey,{'=='});
            TVec = joinRows(TVec,{DCell(1)}); else
            TKey = joinRows(TKey,{'-'}); TVec = joinRows(TVec,{DCell});
        end, else, TKey = joinRows(TKey,{'=='});
        TVec = joinRows(TVec,{DCell});
    end,tmpKey = key2view([],TKey(end),TVec{end},'cell');
    Tpks = joinRows(Tpks,tmpKey); % Key Structures:
end,Key = struct('vec',[]); Key.('vec') = TVec; Key.('keys') = TKey;
Key.('key') = Tpks;


end


% Articulates Names
function name = key2view(name,key,vec,type)
% articulates numerical boundary ranges of binary groupings
% Inputs: (name,key,vec,type)
% Outputs: Name cell strings

if isempty(name) == 0
    switch charFormat(key)
        case {'-'}, num1 = value2string(vec(1),'raw','char');
            num2 = value2string(vec(2),'raw','char');
            name = charFormat(name); name = [name '_' num1 '_to_' num2];
        case {'=='}, num1 = value2string(vec(1),'raw','char');
            name = charFormat(name); name = [name '_' num1];
    end, else
    switch charFormat(key)
        case {'-'}, num1 = value2string(vec(1),'raw','char');
            num2 = value2string(vec(2),'raw','char');
            name = [num1 '-to-' num2];
        case {'=='},num1 = value2string(vec(1),'raw','char');
            name = num1;
    end
end

if nargin == 4
   switch type
       case 'char', name = charFormat(name);
       case 'cell', name = cellstr(name);
   end
end

end


% get unique groups
function [grp,Pct,uqeData] = uqeGrp(data,n)
% Allocates bins to catigorical cell grouped numeric vectors
% Inputs - grouped numeric vector, number of avalible bins
% Outputs - bins allocated to grp vectors, pct of data per bin, unique data

[uqeData,Pct] = uqePct(data); grp = zeros(1,2);
Thresh = 1/n; k = 0; total = 0;

for i = 1:n, k = k + 1; grp(i,1) = k;
    while total < Thresh*i && k < length(Pct)
        total = total + Pct(k); k = k + 1;
    end, grp(i,2) = k; if k == length(Pct), break, end
end,grp(:,1:end) = uqeData(grp(:,1:end));

end


% generate catigorical key:
function [Key,d,PNaN,PEmy,type,inf] = genCatKey(d)
 % 1. str - isolated strings  2. vCat - data vector
 
dataTemp = str2double(d);
if getNnE(dataTemp) < .50, d = dataTemp; % if intiger vals
    type = 'str_double'; Key ={'Not-Applicable'}; else   
    clear dataTemp,  type = 'categorical'; vCat = categorical(d); 
    str = categories(vCat);    DL   = length(d);
    str = str(ismember(str,{'NAN','NaN','NA','no data'}) == 0);
    
    if sum(ismember(str,{'yes','no'}))/length(str) == 1 % case Y or N
        type = 'binary';  d = NaN(DL,1); d(ismember(vCat,'yes')) = 1;
        d(ismember(vCat,'no')) = 0; sKey = {'yes','no'}; vecKey = [1,0];  
    elseif length(str) == 2 % other binary data
        type = 'binary'; vecKey = [1,0]; d = NaN(DL,1); 
        d(ismember(vCat,str(1)))  = 1; d(ismember(vCat,str(2))) = 0;
        sKey = {charFormat(str(1)),charFormat(str(2))}; else
        d = NaN(DL,1);  sKey = [];  vecKey = [];
        for i = 0:length(str)-1, sKey = joinRows(sKey,cellstr(str(i+1)));
            vecKey = joinRows(vecKey,i);
            d(ismember(vCat,cellstr(str(i+1)))) = i;
        end % upload catigorical data to structure
    end, Key = struct('key',[]); Key.('key') = sKey; Key.('vec') = vecKey;
    Key.('type') = type;
end, [PNaN,PEmy,inf] = getNnE(d);

end


function [PNaN,PEmy,inf] = getNnE(Data)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
DL = length(Data);
PNaN = sum(isnan(Data))/DL;
PEmy = sum(isempty(Data))/DL;
inf = sum(isempty(Data))/DL;  
end


% create catigorical bar graph
function H = catigorical2bar(data,key)

[uqeData,Pct,~] = uqePct(data);
if isstruct(key), Ytks = key.('key'); Yves = key.('vec');
    Ytks = Ytks(getIndex(Yves,uqeData,'delete'));
    funPlot('bar',Pct,Ytks,2), else, xlbe = {'a'};
    for i = 1:length(uqeData)
        xlbe(i) = value2string(uqeData(i),'number','cell');
    end
    
    H = funPlot('bar',Pct,xlbe);
end

end


% get percentage of unique data
function [uqeData,Pct,tLD] = uqePct(data)
% percentage of unique groups present
data = data(all(~isnan(data),2),:);
uqeData = sortrows(unique(data)); tLD = length(data);

for i = 1:length(uqeData)
    if i == 1, Pct = sum(data == uqeData(i))/tLD; else
        Pct(i,1) = sum(data == uqeData(i))/tLD;
    end
end




end


% cell pct function:
function [Pct,Bins] = pctCInside(Cell,n)
% percent of data in cells.

Lg = length(Cell); if Lg == 1; Pct = 1; Bins = n; return, end, Pct = [];

for i = 1:Lg, Pct = joinRows(Pct,length(Cell{i})); end
Pct = Pct./sum(Pct);

if nargout == 2
    if n < Lg, Bins = ones(Lg,1); else
        [~,I] = sortrows(Pct); Bins = zeros(Lg,1); PctTotal = 0;
        for i = 1:Lg,  II = I(i); Percent = Pct(II)/(1-PctTotal);
            Bins(II) = floor(n.*Percent);
            if Bins(II) == 0, Bins(II) = 1; end
            n = n - Bins(II); PctTotal = PctTotal + Pct(II);
            if i == Lg, Bins(II) = Bins(II) + n; end
        end
    end
end


end


