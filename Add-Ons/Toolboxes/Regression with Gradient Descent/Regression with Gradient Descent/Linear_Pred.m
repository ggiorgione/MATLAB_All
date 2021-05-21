clc
close all
clear all
%% Dummy System representation by Linear Equation Y=mx+b; m=5,b=8 ;
% Training Data Creation
x=-10:0.1:10;
yt=5*x + 8+20*rand(1,length(x));
%% NN Parameters Declaration
alpha=0.001;
m=randn();
b=randn();
epochs=10;
ind=randperm(length(x));
y=0*yt;
for i=1:epochs
    for n = 1: length(x)
        y(ind(n))=m*x(ind(n)) + b;
        e(n)=(yt(ind(n))-y(ind(n)));
        m=m+alpha*x(ind(n))*e(n);
        b=b+alpha*e(n);
    end
I(i)=sum(e.^2);
y=m*x+b;
subplot(2,1,1)
plot(x,yt);
hold on
plot(x,y,'r');
pause(0.1)
hold off
end
y=m*x+b;
subplot(2,1,1)
plot(x,yt);
hold on
plot(x,y,'r');
legend('Desired','Output','Location','Best');
xlabel('Input   :   Value of X');
ylabel('Output  :   Value of Y');
title('Input/Output Graph');
subplot(2,1,2)
plot(I);
xlabel('Number of Epochs');
ylabel('Mean Squared Error (MSE)');
title('Cost Function');
I(end)
[m b]