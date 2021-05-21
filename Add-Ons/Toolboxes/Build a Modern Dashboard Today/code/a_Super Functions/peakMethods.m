function [out1,out2,out3] = peakMethods(type,varargin)
% Original IsolatePeaks function:
% Type
% -------------------------------------------------------------------------
% 'Original' - X-Data, Y-Data, Map-Data
% Output: Peaks = [Y, X, Max | Min, Returns] -- [Peaks,MaxPks,MinPks]
% -------------------------------------------------------------------------
% 'advanced' - X-Data, Y-Data, 'type' - Vectors
% -------------------------------------------------------------------------

switch type
    case 'original', [out1,out2,out3] = PriceAndNonPrice(varargin{:});
    case 'advanced', [out1,out2,out3] = FlexAndMaxMin(varargin{:}); 
end

end


% Original Function:
function [Peaks,MaxPks,MinPks] = PriceAndNonPrice(varargin)
s = inputMethods('basic',{'x','y','p'},varargin); 

[MaxPeaks,MaxLoc]  = findpeaks(s.y); % Find Maximum:
MaxPeaks(:,2) = s.x(MaxLoc,1); MaxPeaks(:,3) = ones(size(MaxPeaks,1),1);
[~,MinLoc] = findpeaks(-1*s.y); MinPeaks = s.y(MinLoc,1); % Find Minimum:
MinPeaks(:,2) = s.x(MinLoc,1); MinPeaks(:,3) = zeros(size(MinPeaks,1),1);

if isempty(s.p) == 0, MaxPeaks(:,4) = s.p(MaxLoc,1); % find val in array
    MinPeaks(:,4) = s.p(MinLoc,1);
end % Nxt - Combind Data Sort Rows:: set Peak returns

Peaks = [MaxPeaks; MinPeaks]; Peaks = sortrows(Peaks,2); 
MaxPks = Peaks((Peaks(:,3)==1),:);
MinPks = Peaks((Peaks(:,3)==0),:);


end


% New Advanced Peak Function:
function [Max,Min,Peaks] = FlexAndMaxMin(varargin)
s = inputMethods('basic',{'x','y','p'},varargin);  % import data 2 struct
I = (1:length(s.y))'; E = max(I); I = I(isnan(s.y)); % find NaN's
[Max,MaxLoc] = findpeaks(s.y); Max = GenerateMaxMin(Max,MaxLoc,I,E);
[~,MinLoc] = findpeaks(-1.*s.y); Min = s.y(MinLoc,1); % Find Minimum
Min = GenerateMaxMin(Min,MinLoc,I,E); % Nxt, add First and Last Points:
[Max, Min] = addOnFirstAndEnd(Max,Min,s.x,s.y);% Combind Data Sort Rows
Peaks = [Max; Min]; Peaks = sortrows(Peaks,2); % set Peak returns


end


function s = GenerateMaxMin(Max,MaxLoc,I,E)
s = struct('mid',[]); s.('top') = []; s.('bot') = [];

for i = 1:length(MaxLoc) + 1
    if i ~= 1 && i ~= length(MaxLoc) + 1 % not either extreme
        s.mid = joinRows(s.mid,[Max(i-1) MaxLoc(i-1) MaxLoc(i)-1]);
        
    elseif i == length(MaxLoc) + 1 && I(end) <= MaxLoc(end)
        s.mid = joinRows(s.mid,[Max(i-1) MaxLoc(i-1) E]);
             
    elseif i == 1 && I(1) < MaxLoc(1)
        s.bot = joinRows(s.bot,[NaN 1 MaxLoc(i)-1]);
        
    elseif i == length(MaxLoc) + 1 && I(end) > MaxLoc(end)
        s.top = joinRows(s.top,[NaN MaxLoc(i-1) E-1]);
    end
end

end


% Add start and end Conditions:
function [Max, Min] = addOnFirstAndEnd(varargin)
s = inputMethods('safe',{'max','min','x','y'},varargin); 

I = (isnan(s.y) == 0); s.('ynan') = s.y(I); s.('xnan') = s.x(I);
s.('maxy') = s.max.mid(:,1); s.('maxx') = s.max.mid(:,2);
[X,Y] = calcPoint('max',s); PEMax = [Y(2) s.min.mid(end,3)+1 X(2)]; 
PSMax = [Y(1) X(1) s.max.mid(1,2)]; s.('minx') = s.min.mid(:,2); 
s.('miny') = s.min.mid(:,1); [X,Y] = calcPoint('min',s); 
PSMin = [Y(1) X(1) s.min.mid(1,2)]; PEMin = [Y(2) s.min.mid(end,3)+1 X(2)];

Max = [PSMax; s.max.mid; PEMax]; Min = [PSMin; s.min.mid; PEMin];
if isempty(s.max.top) == 0, Max(end+1,:) = s.max.top; end
if isempty(s.min.top) == 0, Min(end+1,:) = s.min.top; end
if isempty(s.max.bot) == 0, s.max.bot(3) = Max(1,2) - 1;
    Max(end+1,:) = s.max.bot; Max = Max([end, 1:end-1],:);
end
if isempty(s.max.bot) == 0, s.min.bot(3) = Min(1,2) - 1;
    Min(end+1,:) = s.min.bot;  Min = Min([end,1:end-1],:);
end


[~,Index]=unique(Max,'rows','first'); Max = Max(Index,:);
[~,Index]=unique(Min,'rows','first'); Min = Min(Index,:);

Max = sortrows(Max,2); Min = sortrows(Min,2);

end


% Add start and end Conditions:
function [xL,Y] = calcPoint(type,s)
yL = s.ynan(1); yL(2) = s.ynan(end); Y = zeros(2,1); P = zeros(2,1);
switch type
    case 'min',xs = s.minx(1:2); ys = s.miny(1:2);
               xe = s.minx(end-1:end); ye = s.miny(end-1:end); 
    case 'max',xs = s.maxx(1:2); ys = s.maxy(1:2);
               xe = s.maxx(end-1:end); ye = s.maxy(end-1:end); 
end, xL = s.xnan(1); xL(2) = s.xnan(end); % solve for projected values
P(1) = ys(1) + (xL(1) - xs(1)) * (ys(2) - ys(1))/(xs(2) - xs(1));
P(2) = ye(2) + (xL(2) - xe(2)) * (ye(2) - ye(1))/(xe(2) - xe(1));



for i = 1:2
    switch type
        case 'min', if yL(i) < P(i), Y(i) = yL(i); else, Y(i) = P(i); end
        case 'max', if yL(i) > P(i), Y(i) = yL(i); else, Y(i) = P(i); end
    end
end

end