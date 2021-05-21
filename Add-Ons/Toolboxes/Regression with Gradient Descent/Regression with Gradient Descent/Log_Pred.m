clc
close all
clear all
%% Dummy System representation by Polynomial Equation Y=a*log(x); a=5;
% Training Data Creation
x=-100:0.3:100;
yt=5*log(x);
% yt=randn(1,length(x));
%% NN Parameters Declaration
alpha=0.001;
a=randn();
% b=randn();
% c=randn();
epochs=10;
ind=randperm(length(x));
y=0*yt;

%% NN Implementation
for i=1:epochs
    for n = 1: length(x)
        y(ind(n))=a*log(x(ind(n)));
        e(n)=(yt(ind(n))-y(ind(n)));
        a=a+alpha*e(n)*log(x(ind(n)));
%         b=b+alpha*e(n)*x(ind(n));
%         c=c+alpha*e(n);
    end
I(i)=sum(abs(e).^2);    
end

subplot(2,1,1)
plot(x,yt);
hold on
plot(x,(a*log(x)),'r');
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
[a]