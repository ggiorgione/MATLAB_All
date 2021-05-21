clc
close all
clear all
%% Dummy System representation by Polynomial Equation Y=ax^2+bx+c; a=2,b=7,c=-4;
% Training Data Creation
x=-10:0.1:10;
yt=2*x.^2 + 7*x -4;
% yt=randn(1,length(x));
%% NN Parameters Declaration
alpha=0.0002;
a=randn();
b=randn();
c=randn();
epochs=1000;
ind=randperm(length(x));
y=0*yt;

%% NN Implementation
for i=1:epochs
    for n = 1: length(x)
        y(ind(n))=a*x(ind(n)).^2 + b*x(ind(n)) + c;
        e(n)=(yt(ind(n))-y(ind(n)));
        a=a+alpha*e(n)*x(ind(n)).^2;
        b=b+alpha*e(n)*x(ind(n));
        c=c+alpha*e(n);
    end
I(i)=sum(e.^2);    
end

subplot(2,1,1)
plot(x,yt);
hold on
plot(x,(a*x.^2 + b*x +c),'r');
legend('Desired','Output','Location','Best');
xlabel('Input   :   Value of X');
ylabel('Output  :   Value of Y');
title('Input/Output Graph');
hold off
subplot(2,1,2)
plot(I);
xlabel('Number of Epochs');
ylabel('Mean Squared Error (MSE)');
title('Cost Function');
pause(0.01)
% end
I(end)
[a b c]