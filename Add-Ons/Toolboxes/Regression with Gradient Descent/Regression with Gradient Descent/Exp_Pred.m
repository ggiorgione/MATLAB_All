clc
close all
clear all
%% Dummy System representation by Polynomial Equation Y=a*log(x); a=5;
% Training Data Creationz
x=-10:0.01:10;
yt=15*exp(x);
% yt=randn(1,length(x));
%% Parameters Declaration
alpha=0.00000001;
a=randn();
% b=randn();
% c=randn();
epochs=10;
ind=randperm(length(x));
y=0*yt;

%% NN Implementation
for i=1:epochs
    for n = 1: length(x)
        y(ind(n))=a*exp(x(ind(n)));
        e(n)=(yt(ind(n))-y(ind(n)));
        a=a+alpha(i)*e(n)*exp(x(ind(n)));
%         b=b+alpha*e(n)*x(ind(n));
%         c=c+alpha*e(n);
    end
alpha(i+1)=0.5*alpha(i)+5e-20*sum(abs(e).^2);
I(i)=sum(abs(e).^2);    
end

subplot(3,1,1)
plot(x,yt);
hold on
plot(x,(a*exp(x)),'r');
legend('Desired','Output','Location','Best');
xlabel('Input   :   Value of X');
ylabel('Output  :   Value of Y');
title('Input/Output Graph');
subplot(3,1,2)
plot(I);
xlabel('Number of Epochs');
ylabel('Mean Squared Error (MSE)');
title('Cost Function');
subplot(3,1,3)
plot(alpha)
xlabel('Number of Epochs');
ylabel('Alpha');
title('Alpha vs Epochs');

I(end)
[a]


