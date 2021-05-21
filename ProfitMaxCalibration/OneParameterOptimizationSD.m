%% Definition of the Function for the steepest descent optimization

% load bTime_1209653.mat
% load Revenue_1209653.mat
% load bTime_big2.mat
% load Revenue_big2.mat
% load bTime_1212165.mat
% load Revenue_1212165.mat 
load bTime_EWGT4.mat
load Revenue_EWGT4.mat 

 

CSC = bTime(:,1);
Revenue = Revenue(:,2);
bTime = bTime(:,2);

xmin = 0;
xmax = 30;
step = 0.1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Breakpoint to use the curve fitting app%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% To reach global minimum with STEEPEST DESCENT method

% clear
close all
clc 

alpha = 0;           % Tolerance to reach convergence


% Define two symbolic variables
syms x

B = 3.271e+05*x - 4.486e+06;
R =  673.3*x - 9443;

Breal = 1828800;
Rreal = 3500;

% Define z as function of x and y
z = @(x) (((3.271e+05*x - 4.486e+06 - Breal)^2)...
    + (673.3*x - 9443 - Rreal)^2)/2;

z1 = (((3.271e+05*x - 4.486e+06 - Breal)^2)...
    + (673.3*x - 9443 - Rreal)^2)/2;
gradient(z1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Breakpoint to write the partial derivatives from the gradient%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Gradient on x
dzdx = @(x) (10699486333289*x)/100 - 20655797945219/10;
 
% Plot z seen from above
% fcontour(z)
% fsurf(z)
% grid

fplot(z,[xmin xmax])
xlabel('α_c_s')
ylabel('ẑ')

%% Optimization procedure

i = 1;  
xtable = (xmin:step:xmax);
 
for j = 1:length(xtable)
    x = xtable(j);
    % First cycle
    % x = 10; y = 1; % Starting point
    xscalar(i) = x;

    if x>0
        hold on
        plot(x,'o')
    end

    % Movement downwards from the starting point 
    sx=-dzdx(x);

    % Line identification where to move
    xd=@(d) x+d*sx;

    % Movement in z
    zd=@(d) z(xd(d));

    % subplot 212
    % fplot(zd)
    % grid

    % Take the maximum step admissable towards the line zd
    d_star=fminsearch(zd,0);
    i = i+1;
    x=xd(d_star);
    xscalar(i) = x;

    % subplot 211
    if x>0
        hold on
        plot(x,'o')
    end
%     plot(xscalar,'-r')

    zfin(i,:) = z(x);

    while zfin(i-1) - zfin(i) ~= alpha 
        % Other cycles
        if x>0
            hold on
            plot(x,'o')
        end
        
        % Movement downwards from the starting point 
        sx=-dzdx(x);

        % Line identification where to move
        xd=@(d) x+d*sx;

        % Movement in z
        zd=@(d) z(xd(d));

    %     subplot 212
    %     fplot(zd)
    %     grid

        % Take the maximum step admissable towards the line zd
        d_star=fminsearch(zd,0);
        i = i+1;

        x=xd(d_star);

        xscalar(i) = x;

    %   subplot 211
        if x>0
            hold on
            plot(x,'o')
        end
%         plot(xscalar,'-r')
        zfin(i,:) = z(x);
    end
    zFIN(j) = zfin(end,:);
end

