%% Definition of the Function for the steepest descent optimization
load Bookings_new.mat
load Revenue_new.mat

CSCb = Bookings(:,1);
MUoMb = Bookings(:,2);
Bookings = Bookings(:,3);

CSCr = Revenue(:,1);
MUoMr = Revenue(:,2);
Revenue = Revenue(:,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Breakpoint to use the curve fitting app%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% To reach global minimum with STEEPEST DESCENT method

clear
close all
clc 

alpha = 0;           % Tolerance to reach convergence


% Define two symbolic variables
syms x y

% Objective function z = (((B-Breal)^2)+((R-Rreal)^2))/2;

% B = 162.6*x - 1484*y + 77.85;
% R = 2455*x - 28930*y + 2049;

% B = 162.6*x - 1484*y + 77.85;
% R = 2455*x - 28930*y + 2049;

% B = 185.2*x - 1767*y + 46.33;
% R = 2319*x - 26570*y + 1254;

% B = 91.22 + 181*x -2100*y + 42.78*x^2 - 972.8*x*y + 5952*y^2;
% R = 2459 + 3977*x - 53630*y -155*x^2 + 172.3*x*y + 30320*y^2;

B = 94.46 + 395.2*x - 1943*y - 576.3*x^2 + 4225*x*y - 6290*y^2;
R = 3895 + 15860*x - 92520*y - 23290*x^2 + 169900*x*y - 248900*y^2;

Breal = 130;
Rreal = 4387;

% Define z as function of x and y
% z = @(x,y) (((91.22 + 181*x -2100*y + 42.78*x^2 - 972.8*x*y + 5952*y^2 - Breal)^2)...
%     + (2459 + 3977*x - 53630*y -155*x^2 + 172.3*x*y + 30320*y^2 -Rreal)^2)/2;
% z1 = (((91.22 + 181*x -2100*y + 42.78*x^2 - 972.8*x*y + 5952*y^2 - Breal)^2)...
%     + (2459 + 3977*x - 53630*y -155*x^2 + 172.3*x*y + 30320*y^2 -Rreal)^2)/2;
% gradient(z1);

% z = @(x,y) (((162.6*x - 1484*y + 77.85 - Breal)^2) + (2455*x - 28930*y + 2049-Rreal)^2)/2;
% z1 = ((162.6*x - 1484*y + 77.85 - Breal)^2 + (2455*x - 28930*y + 2049-Rreal)^2)/2;
% gradient(z1);

% z = @(x,y) (((185.2*x - 1767*y + 46.33 - Breal)^2) + (2319*x - 26570*y + 1254 - Rreal)^2)/2;
% z1 = ((185.2*x - 1767*y + 46.33 - Breal)^2 + (2319*x - 26570*y + 1254 - Rreal)^2)/2;
% gradient(z1);

z = @(x,y) (((94.46 + 395.2*x - 1943*y - 576.3*x^2 + 4225*x*y - 6290*y^2 - Breal)^2)...
    + (3895 + 15860*x - 92520*y - 23290*x^2 + 169900*x*y - 248900*y^2 -Rreal)^2)/2;
z1 = (((94.46 + 395.2*x - 1943*y - 576.3*x^2 + 4225*x*y - 6290*y^2 - Breal)^2)...
    + (3895 + 15860*x - 92520*y - 23290*x^2 + 169900*x*y - 248900*y^2 -Rreal)^2)/2;
gradient(z1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Breakpoint to write the partial derivatives from the gradient%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Gradient on x
% dzdx=@(x,y) ((2139*x)/25 - (4864*y)/5 + 181)*((2139*x^2)/50 - (4864*x*y)/5 + 181*x + 5952*y^2 - 2100*y - 1939/50)...
%     + ((1723*y)/10 - 310*x + 3977)*(- 155*x^2 + (1723*x*y)/10 + 3977*x + 30320*y^2 - 53630*y - 928);
% dzdx=@(x,y) (151336594*x)/25 - (356322242*y)/5 - 329326959/100;
% dzdx=@(x,y) (135301501*x)/25 - (309715392*y)/5 - 1240480671/250;
dzdx=@(x,y)- (4225*y - (5763*x)/5 + 1976/5)*((5763*x^2)/10 - 4225*x*y - (1976*x)/5 ...
    + 6290*y^2 + 1943*y + 1777/50) - (169900*y - 46580*x + 15860)* ...
    (23290*x^2 - 169900*x*y - 15860*x + 248900*y^2 + 92520*y + 492);
 
% Gradient on y
% dzdy=@(x,y) ((1723*x)/10 + 60640*y - 53630)*(- 155*x^2 + (1723*x*y)/10 + 3977*x + 30320*y^2 - 53630*y - 928)...
%     - ((4864*x)/5 - 11904*y + 2100)*((2139*x^2)/50 - (4864*x*y)/5 + 181*x + 5952*y^2 - 2100*y - 1939/50);
% dzdy=@(x,y) 839147156*y - (356322242*x)/5 + 193928653/5;
% dzdy=@(x,y) 709087189*y - (309715392*x)/5 + 5682165489/100;
dzdy=@(x,y) (12580*y - 4225*x + 1943)*((5763*x^2)/10 - 4225*x*y - (1976*x)/5 ...
    + 6290*y^2 + 1943*y + 1777/50) + (497800*y - 169900*x + 92520)* ...
    (23290*x^2 - 169900*x*y - 15860*x + 248900*y^2 + 92520*y + 492);

% Plot z seen from above
% subplot 211;
fcontour(z)
% fsurf(z)
grid

%% Optimization procedure

i = 1;  

% First cycle
x = -0.499; y = 0.487; % Starting point
zfin(i,:) = 0;
xscalar(i) = x;
yscalar(i) = y;

hold on
plot(x,y,'o')

% Movement downwards from the starting point 
sx=-dzdx(x,y);
sy=-dzdy(x,y);

% Line identification where to move
xd=@(d) x+d*sx;
yd=@(d) y+d*sy;

% Movement in z
zd=@(d) z(xd(d),yd(d));

% subplot 212
% fplot(zd)
% grid

% Take the maximum step admissable towards the line zd
d_star=fminsearch(zd,0);
i = i+1;
x=xd(d_star);
y=yd(d_star);
xscalar(i) = x;
yscalar(i) = y;

% subplot 211
hold on
plot(x,y,'o')
plot(xscalar,yscalar,'-r')

zfin(i,:) = z(x,y);

while zfin(i-1) - zfin(i) ~= alpha
    % Other cycles
    hold on
    plot(x,y,'o')

    % Movement downwards from the starting point 
    sx=-dzdx(x,y);
    sy=-dzdy(x,y);

    % Line identification where to move
    xd=@(d) x+d*sx;
    yd=@(d) y+d*sy;

    % Movement in z
    zd=@(d) z(xd(d),yd(d));

%     subplot 212
%     fplot(zd)
%     grid

    % Take the maximum step admissable towards the line zd
    d_star=fminsearch(zd,0);
    i = i+1;

    x=xd(d_star);
    y=yd(d_star);
    
    xscalar(i) = x;
    yscalar(i) = y;

%     subplot 211
    hold on
    plot(x,y,'o')
    plot(xscalar,yscalar,'-r')
    zfin(i,:) = z(x,y);
end
% zfin = z(x,y);