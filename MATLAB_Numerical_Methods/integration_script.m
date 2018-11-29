clear all
close all
clc

f1 = inline('cos(x)','x');
f2 = inline('(x.^2).*exp(-x)','x');
f3 = inline('x.*exp(-2*x.^2)','x');
x1 = 0;
x2 = 2;
h = 0.01;
value1 = trapezoidal(f3,x1,x2,h)
value2 = simpson_1_3(f3,x1,x2,h)
value3 = simpson_3_8(f3,x1,x2,h)
value4 = adaptive_int(f3,x1,x2,0.000001)