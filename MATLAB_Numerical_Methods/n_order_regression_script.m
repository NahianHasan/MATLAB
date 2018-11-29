tic
clear all
clc

x = input('set the x values of data points:');
y = input('set the y values of data points:');
m = input('order of the regression model:');

P = n_order_regression3(x,y,m);
M = length(P)-1;
Y = [];
L = min(x(:));
H = max(x(:));
for i = L:.1:H
    c = P(1);
    for j = 1:M
        c = c + P(1+j) * power(i,j);
    end
    Y = [Y c];
end

s = L:.1:H;
plot(s,Y,x,y,'*');
legend('regression Line');
title(['Regression model of order ',num2str(m)]);
xlabel('Error Percentage');
ylabel('Actual temperature');
toc