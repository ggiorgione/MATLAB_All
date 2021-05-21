clc
close all
clear all
%% Dummy System representation ;
%% Training Data Creation
x=-1000:2:1000;
yt=10*randn(1,length(x));%5*sin(2*pi*1*x*0.1) + 8;
%% Parameters Declaration
alpha=0.1;
f=randn(1,length(x));
a=randn();
b=randn(1,length(x));
epochs=10;
ind=randperm(length(x));
y=0*yt;
%% Iterations
for i=1:epochs
    for n = 1: length(x)
        y(ind(n))=a*sin(2*pi*f(ind(n)).*x(ind(n))*0.01) + b(ind(n));
        e(n)=(yt(ind(n))-y(ind(n)));
        a=a+alpha(i)*sin(2*pi*f(ind(n)).*x(ind(n))*0.01)*e(n);
        b(ind(n))=b(ind(n))+alpha(i)*e(n);
        f(ind(n))=f(ind(n))-alpha(i)*e(n)*cos(2*pi*f(ind(n)).*x(ind(n))*0.01)*2*pi*x(ind(n))*0.01;
    end
   alpha(i+1)=0.9*alpha(i)+5e-6*sum(abs(e).^2); 
   hold off
   plot(x,yt);
   hold on
   plot(x,y,'r');
   pause(0.1)
I(i)=sum(e.^2);    
end
%% Testing
close all
plot(alpha)
figure
y=a*sin(2*pi*f*0.01.*x) + b;
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
% [a b]