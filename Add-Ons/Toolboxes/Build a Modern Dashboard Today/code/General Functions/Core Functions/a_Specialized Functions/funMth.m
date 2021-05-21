function [d1,d2,d3] = funMth(type,varargin)
% the following function preforms several mathmatical operations all
% ranging in complexity. the goal is to encapsulate as many funcations as
% in as little functions. The following methods include:
% -------------------------------------------------------------------------
% 'mag' - absolute magnitude of vector for a range of data types
% Input: X array | 2D, 4 vector input X0, X1, Y0, Y1
% Output: absolute distance vector, sqrt( x^2 + y^2)
% Handles: if X array then type, 'col' or 'row'
% -------------------------------------------------------------------------
% 'fzstd' - Frequency Standard deviation
% Input: data points, frequency of data points
% Output: standard deviation, mean
% -------------------------------------------------------------------------
% 'ang' - angle of vector, for a range of inputs
% Inputs: ([x y]), (x, y), (origin, [x y])
% Output: angle of vector realtive to origin.
% -------------------------------------------------------------------------
% 'circle' - get the x and y coordiates of a circle
% Inputs: (Center, radius, n-gradulatirty)
% Outputs: [x-coordinates, y-coordinates]
% Handles: plot, {'on' | 'off'} default off
% -------------------------------------------------------------------------
% 'radius' - calculate the radius of the circle
% Inputs - [x,y] radial coordinate if center is [0,0]
%          [x-center ycenter; x-point, y-point]
% Output - [radius, x-point, y-point]
% -------------------------------------------------------------------------
% 'lap' - laplace expodential transfer function filter
% Inputs: filter type, right pnt, right exp, left pnt, left exp, handles
% Outputs: [x-coordinates, y-coordinates]
% Handles: 'Const' - Maximum value default = 1
%          'plot'  - plot data default = 'off'
% -------------------------------------------------------------------------
% 'ratio' - calculate a two variable ratio
% Inputs - a - vetor or number, b - vector or number
% Output - d1 = [weighted a, weighted b], inverse of d2
% -------------------------------------------------------------------------
% 'sigmf' - generate sigmoid variable functio
% Inputs - X,a,c,d,e,type
% Output - d1 = [weighted a, weighted b], inverse of d2
% Notes: Y = 1./(1+exp[-a*.((e.*X)-c))];
%        X = X./d
% -------------------------------------------------------------------------


switch type
    
    case 'mag',     d1 = magVc(varargin{:});
    case 'fzstd',  [d1,d2] = calcFzSTD(varargin{:});
    case 'ang',     d1 = getAng(varargin{:});
    case 'circle', [d1,d2] = get_Circle(varargin{:});
    case 'radius', [d1,d2,d3] = calcRadius(varargin{:});
    case 'lap',     d1 = getLaplaceFilter(varargin{:});
    case 'ratio',  [d1,d2] = funRatio2(varargin{:});
    case 'tri',     d1 = triRelativity(varargin{:});
    case 'otri',    d1 = triOpti(varargin{:});
    case 'pct',     d1 = pctError(varargin{:});
    case 'mzscore', d1 = mzscorefun(varargin{:});
    case 'sigmf',   d1 = sigmfun(varargin{:});
        
end


end

% calculate 2-D ratio
function [o,oinv] = funRatio2(a,b)

la = length(a); lb = length(b);

if la ~= lb
   error('length a does not equal length b') 
end

I  = a == 1 & b == 1;

o = zeros(length(a),2);
o(I == 0,1) = ((a(I == 0).*(1-b(I == 0)))./(1-a(I == 0).*b(I == 0)));
o(I == 0,2) = (1-a(I == 0))./(1-a(I == 0).*b(I == 0));
IV = ((I').*([.5 .5]));
o(:,I) = IV(:,I);
oinv   = 1 - o;

end

% sigmoid function
function Y = sigmfun(X,a,c,d,e,type)
% Set up initial Function to map to expodential
% Y = 1./(1+exp[-a*.((e.*X)-c))];
% X = X./d


if nargin == 6
    if strcmpi(type,'length') || length(X) == 1
        X = 1:X;
    end
end

switch nargin
    case 1, Y = 1./(1+exp(-1.*X));
    case 2, Y = 1./(1+exp(-a.*X));
    case 3, Y = 1./(1+exp(-a.*(X-c)));
    case 4, Y = 1./(1+exp(-a.*(X-c)));    X = X./d;
    case 5, Y = 1./(1+exp(-a.*(e.*X-c))); X = X./d;  
    case 6, Y = 1./(1+exp(-a.*(e.*X-c))); X = X./d;  
end


if nargout == 0, plot(X,Y), title('Expodental Curve')
   xlabel('Independent Variable'), ylabel('Depentent Variable')
end

end

% calculate moving z-score
function Zscore = mzscorefun(X,Window)
% Moving Z-Score With Filled In NaN's
Zscore = (X-movmean(X,Window,'Endpoints','fill'))./movstd(X,Window);
end

% get magnitude vector:
function d = magVc(varargin)
% Calculate the Magnitude given two coordinate points [X0 Y0] & [X1 Y1]
if rem(length(varargin),2) % if is odd
    s = inputMethods('adv',{'type'},{'col'},{'X'},varargin); s.('dim') = 1;
else
    s = inputMethods('basic',{'X0','X1','Y0','Y1'},varargin);s.('dim') = 2;
end

if s.dim == 1
   if strcmpi(s.type,'col')
       d = sqrt(sum((s.X(1:end,:).^2),2));
   elseif strcmpi(s.type,'row')
       d = sqrt(sum((s.X(:,1:end).^2),1));
   else
      error('Orientation does not exist') 
   end, return
end

L  = length(s.X0); % for the vectorized version the type orientation is
d = zeros([L 1]);  % not important because the are all 1-Dim.
d(1:L,1) = sqrt((s.X0(1:L) - s.X1(1:L))^2 + (s.Y0(1:L) - s.Y1(1:L))^2);

end

% calculate freqency Standard Deviation
function [stdNum,m] = calcFzSTD(x,xf)
% This Function takes a frequency standard deviation where x are you x
% values xf is your freqency and m is your mean.

m = sum(xf.*x)./sum(xf);
stdNum =sqrt(dot(((x-m)').^2,xf)/(sum(xf)-1));

end

% angle methods
function Ang = getAng(in1, in2)
% Get true angle in degrees:
% nargin == 1
% a. vector has to be centered at the origin.
%
% nargin == 2
% a. column vectors of x, y centered at origin
% b. origin location, radial vector

switch nargin % Look at nargin inputs
    
    case 1, v1 = [1 0]; v2 = in1; % a.
    case 2
        if size(in1,2) == 1, v1 = [1 0]; v2 = [in1 in2];
        elseif size(in2,2) == 2 % b. | next if in1 is the origin.
            if in1(1) == 0 && in1(2) == 0, in1 = [1 0]; 
            end,v1 = in1; v2 = in2; else
           error('Invalid input') 
        end
end

TL = size(v2,1); Ang = zeros([TL 1]);
for i = 1:TL, Ang(i) = acosd(dot(v1,v2(i,:))/(norm(v1)*norm(v2(i,:))));
if length(v1) == 2, H = norm(v2); AT = asind(sin((v2(2)-v1(2))/H));
    if Ang(i) <= 180 && AT <= 0, Ang(i) = 360 - abs(Ang(i)); end
end

end
end

% Circle methods
function [x,y] = get_Circle(varargin)
% the following function will get the x, y points of a circle
% Plot a circle where center is the center of your circle, r is the radius
% and n is the number of iterations and the length of your output vector
%
% inputs:   Center - [x-center, y-center]
%           r      - Radius value
%           n      - granularity of data
% Outputs: [x-coordinates, y-coordinates]
% Handles: plot, {'on' | 'off'} default off

WN = {'center','r','n','plot'}; WM = {[0 0],1,1000,'off'};
s = inputMethods('adv',WN,WM,{'center','r','n'},varargin);
d = (s.n/(2*pi)); i = 1:s.n;
x(i,1) = s.r*cos(i/d)+s.center(1); y(i,1) = s.r*sin(i/d)+s.center(2);
if strcmpi(s.plot,'on')
    funPlot('cycle',x,y,0.00001,'Circle Vector Animation');
end


end

% laplace expodential transfer function filter
function DO = getLaplaceFilter(varargin)
% This function allows for users to Weight Data based on a Laplace
% expodential step function filter. The filter has insperation from
% electrical engineering highpass, lowpass, and bandpass filters. The
% inputs are tricky but not impossible 
% 
% Type - [1 0], Highpass Filter
% Type - [0 1], Lowpass Filter
% Type - [1 1], Bandpass Filter
%
% X1       - LowPass Boundry
% X2       - HighPass Boundry
% Exp1     - Lowpass Expodential Coefficent
% Exp1     - Highpass Expodential Coefficent
% Constant - Max Value


WN = {'Const','plot'}; WM = {1,'off'};
s = inputMethods('adv',WN,WM,{'type','n','X1','Ex1','X2','Ex2'},varargin);


DO = zeros([s.n 1]); % Set up Filter Pre Loader:
if s.type(1) == 1 && s.type(2) == 0 % High Pass Filter
    for i = 1:s.n 
        if s.X2 > i,DO(i,1) = s.Const;
        else,     DO(i,1) = s.Const*(1/(exp((i-s.X2)*s.Ex2)));
        end
    end
elseif s.type(1) == 0 && s.type(2) == 1 % Low Pass Filter
    for i = 1: s.n 
        if s.X1 < i, DO(i,1) =  s.Const;
        else,      DO(i,1) = s.Const*(1/(exp((s.X1 - i + 1)*s.Ex1)));
        end
    end
elseif s.type(1) == 1 && s.type(2) == 1 % Band Pass Filter
    for i = 1:s.n 
        if s.X1 <= i && s.X2 >= i, DO(i,1) =  s.Const;
        elseif s.X1 > i, DO(i,1) = s.Const*(1/(exp((s.X1-i)*s.Ex1)));
        elseif s.X2 < i, DO(i,1) = s.Const*(1/(exp((i-s.X2)*s.Ex2)));
        end
    end 
end
if strcmpi(s.plot,'on'), plot(DO), title('Laplase Weighted Filter')
    ylabel('Weight'), xlabel('Element'), hold off
end


end


% calculate radius of circle.
function [radius,p1,p2] = calcRadius(in1,in2)
% calculate the radius of a circle given  two points along the rim of the
% circle. which are denoted by two vectors.
%
% Input: in1 = [x, y] where the center of the circle is at the radius.
%        in1 = [x-center ycenter; x-point, y-point]
%
% p1 - the center of the circle
% p2 - an outer point on the circle

switch nargin
    case 0, error('No Inputs were provided')
    case 1,TS = size(in1); % the input must be greater than one element
        if TS(1) == 1 && TS(2) == 1, error('Invalid Input Argument'), end
        if TS(1) == 1 || TS(2) == 1, p1 = [0 0];  p2 = [in1(1) in1(2)];
        elseif TS(1) == 2 && TS(2) == 2, p1 = in1(1,:); p2 = in1(2,:);
        elseif TS(1) == 2, p1 = in1(1,:); p2 = in1(2,:); 
        elseif TS(2) == 2, p1 = in1(:,1);  p2 = in1(:,2);    
        else, error('Invalid Input Argument')
        end
    case 2, TS = size(in1); TP = length(in2);
        if TP == 1 && TS == 1, p1 = [0 0]; p2 = [in1 in2];    
        elseif TP == 2 && TS == 2, p1 = in1;  p2 = in2;
        else,  error('Invalid Input Argument')
        end
end, radius = sqrt(sum((p1(1:end) - p2(1:end)).^2));

end


% Minimizes distance between nodes.
function c = triOpti(type,a,varargin)
% type specifies which value you are trying to optimize for the value can
% be either x or y, defult is y. The value returned will be the minimum
% value between all locations and your point.

TSize = size(varargin{1});
TLV   = length(varargin);
data  = zeros(TSize,TLV);
c     = zeros(TSize(1),1);


if (TSize(1) == 1 && TSize(2) == 2) || (TSize(1) == 2 && TSize(2) == 1)
    if TLV == 1, data = varargin{1}; c = mean(data); end
end


% unload varagin and get process type:
for i = 1:length(varargin), data(i,:) = varargin{i}; end
if strcmpi(type,'x'), ColVec = 2; else, ColVec = 1; end

% calculate max and min
Max = max(data(:,ColVec)); Min = min(data(:,ColVec));
if Max == Min, c = data(data(:,ColVec) == Max); c = c(1); return, end


Scale = Min:((Max-Min)/100):Max;
if ColVec == 2, y = Scale'; x = ones(length(Scale),1).*a; else
    y = ones(length(Scale),1).*a; x = Scale';
end


for i = 1:TSize(1)
    c = c + triangleRelativity([x y],data(i,:));
end

[~,c] = min(c); c = Scale(c);

end


% calculate the hyp. of a triangle.
function r = triRelativity(x,y,a,b)
% get hypotenuse given to locations: (x,y) and (a,b) in euclidian space.
% where both location (x,y) and (a,b) are both points.

if nargin == 2,     r = sqrt((x(:,1) - y(:,1)).^2 + (x(:,2) - y(:,2)).^2);
elseif nargin == 4, r = sqrt( ( x - a ).^2 + ( y - b ).^2 );
else, error('Invalid Inputs')
end


end

function data = pctError(target,value,Type)
% Calculate Percent Change:
% 
% 1. Value - Norm -> Mean | Predicted, inverse percent diff
% 2. target - Target values
% 3. Type - Inverse or normal value calculation

if nargin == 2, Type = 'norm'; end
switch Type 
    case 'norm', data = (target - value)./target;
    case 'inverse', data = value.*target - target;
end


end


