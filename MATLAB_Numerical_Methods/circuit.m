clear all
close all
clc

f = inline('(15*(6 - y) - 30*y)./5','y');
f1 = inline('(15*(6 - y) - 10*y)./5','y');
xi = 0;
yi = 0;
xf = 2;
h = 0.02;
[X,Y] = my_euler(f,xi,yi,xf,h);


x2i = X(end);
y2i = Y(end);
x2f = 10;
[X1,Y1] = my_euler(f1,x2i,y2i,x2f,h);
x = -5:0.02:0;
y = zeros(1,251);


X3 = [x X X1];
Y3 = [y Y Y1];
plot(X3,Y3)
axis([-5 10 -5 5]);

figure
v1 = f(Y)*5;
v2 = f1(Y1)*5;
v = [y v1 v2];
plot(X3,v)
axis([-5 10 -5 90]);