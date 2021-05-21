function [d1,d2,d3] = numMethods(type,varargin)
% numerical methods function handles numerical vectors, and allows the user
% to interact will vectors on an elemental base level methods include:
% -------------------------------------------------------------------------
% 'lgc' |'logic' - processes data into a binary vector which is derived
% from a user defined range.
% Input: 'data' data vector, 'num' user defined range 
% Outputs: binary vector may change depending on handle input
% handles: build - complete split of data, sect index locations of bin vec
% -------------------------------------------------------------------------
% 'key' | 'sect' - processes data into indicies the maximum indicies that
% can be processed by the method is three.
% Inputs: 'vec' data vector, 'type' - {'val' | 'bin'} 
% Output: [top-idx, bot-idx, 'type'], bin length can be: [1 2 3]
% handles 'process' {'yes' | 'no'}
% -------------------------------------------------------------------------
% 'inv' - only works with data formated to the spects of 'key' | 'sect'.
% the method spits up data based on output sections. and is used as the
% inverse method of 'key' | 'sect' of handle 'type' set to 'val'.
% Input - Section idx-array [top-idx, bot-idx, 'val']
% Output - value vector.
% -------------------------------------------------------------------------
% 'idx' | 'index' - Locates Given value x and an array, the following
% method will locate the index location of x in the given array.
% Inputs: Array, Number where the number can be a vector
% Outputs: [upper-Index, lower-Index]
% -------------------------------------------------------------------------
% 'qidx' | 'qindex' - Locates Given value x and an array, the following
% method will locate the index location of x in the given array.
% Inputs: Array, Number where the number can be a single element.
% Outputs: [upper-Index, lower-Index]
% -------------------------------------------------------------------------
% 'vec' the following function utalizes a compare vector where compare 
% means compare = [ 4 5 7 8 ] 1. [4 - 5], 2. [5 - 7], 3. [7 - 8]

d1 = []; d2 = []; d3 = [];
switch type
    case {'lgc','logic'}, [d1,d2] = LVBuild(varargin{:});
    case {'key','sect'}, d1 = LSBuild(varargin{:});
    case {'inv'}, d1 = CVFun(varargin{:});  
    case {'idx','index'}, [d1,d2] = MainIdxLoop(varargin{:});
    case {'qidx','qindex'}, [d1,d2] = MainIdxPrcss(varargin{:});
    case {'split'},[d1,d2] = cell2splitGrp(varargin{:});
    case {'vec'}, [d1,d2,d3] = VecCmp2bin(varargin{:});
    case {'sgrid'}, d1 = smoothGridFun(varargin{:});
end



end


function grid = smoothGridFun(varargin)

WN = {'window','max'}; WM = {[5 5],50000};
s = inputMethods('adv',WN,WM,{'grid','window'},varargin);

grid = medfilt2(s.grid,s.window); 
grid(1:2,1) = s.max; grid(1,1:2) = s.max;
grid(1,(end-1):end) = s.max; grid(1:2,end) = s.max;
grid((end-1):end,1) = s.max; grid(end,(end-1):end) = s.max;
grid(end,1:2) = s.max; grid((end-1):end,end) = s.max;

end


% create binary binary logical vector
function [data,other] = LVBuild(varargin)
% Output is a vector of ones and zeros
WN = {'process'}; WM = {[]};
s = inputMethods('asafe',WN,WM,{'data','num'},varargin);

if issorted(s.data) == 0, s.data = sortrows(s.data); end % mke data srted
if length(s.num) == 1, data = s.data == s.num; else
    data = (s.data >= min(s.num)) & (s.data <= max(s.num));
end, if isempty(s.process), return, end

switch s.process % if process exists
    case {'build','split'}, data = LSBuild(data,'val','process','yes'); 
    case {'sect'}, data = LSBuild(data,'val','process','no'); 
    case {'grp','group'}, data = LSBuild(data,'val','process','yes');
      [data,other] = cell2splitGrp(s.data,data);  
end

end

% create logical section vector
function Sect = LSBuild(varargin)
% there are four general cases
% 1. no ones are present               2. array is all ones
% 3. top idx is one                    4. bottom idx is length of vector
% 5. else 3 sections
%
% Inputs: 'vector', 'type' - handles 'process' {'yes','no'}
% Output: [top idx, bot idx, binary value], bin length can be: [1 2 3]
WN = {'type','process'}; WM = {'val','no'};
s = inputMethods('asafe',WN,WM,{'vec','type'},varargin);
switch s.type
    case 'val', T = 0; B = 2;   case 'bin', T = 0; B = 0;
end,s.vec = alwaysRow(s.vec); LgVec = length(s.vec); [~,TIdx] = max(s.vec);
[~,BIdx] = max(flip(s.vec)); BIdx = LgVec - BIdx + 1;
if sum(s.vec) == 0, Sect = [1 LgVec 0];   
elseif BIdx == length(s.vec) && TIdx == 1, Sect = [1 LgVec 1];  
elseif TIdx == 1, Sect = [1 BIdx 1; (BIdx+1) LgVec B];  
elseif BIdx == length(s.vec), Sect = [1 (TIdx-1) T; TIdx LgVec 1]; 
else,Sect = [1 (TIdx-1) T; TIdx BIdx 1; (BIdx+1) LgVec B];
end,switch s.process, case {'yes'}, Sect = CVFun(Sect); end

end

% create array from section list
function Vec = CVFun(Sect)
% create vector given indexes

Vec = ones(Sect(end,2),1);
for i = 1:size(Sect,1), Vec(Sect(i,1):Sect(i,2),1) = Sect(i,3); end

end

% get looped index data
function [upr,lwr] = MainIdxLoop(varargin)
% Locates Given value x and an array, the following
% method will locate the index location of x in the given array.
% Given Number = 4
% Ex. Array = [ 9 8 7 6 5 4 3 2 1]
%     Indexs    1 2 3 4 5 6 7 8 9
%
%     index = 6
%

s = inputMethods('basic',{'array','num'},varargin);
s.num = datenum(s.num); T = (1:length(s.array))';
if length(s.num) == 1 % if only one number is requested
    [upr,lwr] = mainAdvanced(s.array,s.num,T); return
end,upr = zeros(1,1); lwr = zeros(1,1); 
for i = 1:size(s.num,1)
    for j = 1:size(s.num,2)
        [upr(i,j),lwr(i,j)] = MainIdxPrcss(s.array,s.num(i),T);
    end
end

end

% get Index location process
function [U,L] = MainIdxPrcss(varargin)
% Locates Given value x and an array, the following
% method will locate the index location of x in the given array.
% Given Number = 4
% Ex. Array = [ 9 8 7 6 5 4 3 2 1]
%     Indexs    1 2 3 4 5 6 7 8 9
%
%     index = 6
%

s = inputMethods('basic',{'array','num','idx'},varargin); I = [];
if isempty(s.idx), s.idx = (1:length(s.array))'; end
if length(s.array) == 1, U = 1; L = 1; return, end
if issorted(s.array) == 0, [s.array,I] = sortrows(s.array); end
if isempty(s.idx)
    s.idx = 1:length(I);
end
if s.array(1) < s.array(2)
    U = min(s.idx(s.array >= s.num)); L = max(s.idx(s.array <= s.num));
    if isempty(U) || isempty(L)
        if s.num < min(s.array), U = 1; L = 1; else
            U = length(s.array); L = length(s.array);
        end
    end, else, U = min(s.idx(s.array >= s.num));
    L = max(s.idx(s.array <= s.num));
    if isempty(U) || isempty(L)
        if N < min(s.array), U = length(s.array); 
            L = length(s.array); else, U = 1; L = 1;
        end
    end
end

if isempty(I) == 0, U = I(U); L = I(L); 

end

end

function [Cells,UqeCells] = cell2splitGrp(varargin)
% split cells based on a logical vector
s = inputMethods('basic',{'data','lgc'},varargin);

Cells = []; UqeCells = unique(s.lgc);
for i = 1:length(UqeCells)
   dst = s.data(s.lgc == UqeCells(i));
   Cells = joinColumns(Cells,{dst});
end


end


% If given vector:
function [dout,T,I] = VecCmp2bin(varargin)
% the following function utalizes a compare vector where compare means
% compare = [ 4 5 7 8 ] 1. [4 - 5], 2. [5 - 7], 3. [7 - 8]
WN = {'type'}; WM = {'all'}; dout = [];
s = inputMethods('asafe',WN,WM,{'data','compare','type'},varargin);

switch type
    case 'all', bot = 1; top = 0;   
    case 'bot', bot = 1; top = 1;   
    case 'top', bot = 2; top = 0;   
    case 'mid', bot = 2; top  = 1;
end,CL = length(s.compare); top = CL - top;

for i = bot:top
    if i == bot
        if bot == 1, newCol = data <= compare(i); else
            newCol = data >= compare(i-1) & data <= compare(i);
        end,elseif i == CL, newCol = data >= compare(i); else
        newCol = data > compare(i-1) & data <= compare(i);
    end,dout = joinColumns(dout,newCol);
end,dout(isnan(data)) = NaN;

I = (sum(dout,2) == 1) | isnan(data); T = I == 0;


end






