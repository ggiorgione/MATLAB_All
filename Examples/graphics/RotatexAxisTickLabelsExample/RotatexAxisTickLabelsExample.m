%% Rotate _x_-Axis Tick Labels
% Create a stem chart and rotate the _x_-axis tick labels so that they
% appear at a 45-degree angle from the horizontal plane.
x = linspace(0,10000,21);
y = x.^2;
stem(x,y)
xtickangle(45)
