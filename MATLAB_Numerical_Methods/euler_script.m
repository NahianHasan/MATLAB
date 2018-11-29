clear all
close all
clc

f = inline('(x-y)/2','x','y');
f1 = inline('3*exp(-x./2) -2 + x','x');
h = [1,0.5,0.25,(1/8)];
figure
title('Euler');
hold on
for i=1:4
[X,Y] = my_euler(f,0,1,3,h(i));
plot(X,Y);
end
x = 0:0.1:3
y = f1(x)
plot(x,y)
legend('h=1','h=0.5','h=0.25','h=0.125','Main','Location','NorthWest');
hold off



figure
title('Improved Euler');
hold on
for i=1:4
[X,Y] = my_improved_euler(f,0,1,3,h(i));
plot(X,Y);
end
x = 0:0.1:3
y = f1(x)
plot(x,y)
legend('h=1','h=0.5','h=0.25','h=0.125','Main','Location','NorthWest');
hold off