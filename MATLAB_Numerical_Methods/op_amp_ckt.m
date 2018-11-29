clear all
close all
clc


f = inline('(-(y/50000) - 0.0001)*100000','y');
f1 = inline('(0.0000004 - (y./100000)).*100000','y');
f2 = inline('(((-5-y)./10000)-(y./10000))*200000','y');
f3 = inline('(9-y)./(10000*0.000002)');
f4 = inline('(10 - y)./(10*0.1)','y')
xi = 0;
yi = -8;
xf = 10;
h = 0.001;
[X,Y] = my_euler(f4,xi,yi,xf,h);
plot(X,Y)
