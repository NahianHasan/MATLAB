clear all
close all
clc

f = inline('x.^5 + x + 1','x');
f1 = inline('exp(-x) - 1','x');
f2 = inline('3*x + sin(x) - exp(x)','x');
f3 = inline('x.^3 - 13.*x - 12','x');
u = inline('x.^2 + x.*y - 10','x','y');
v = inline('y + 3.*x.*y.*y - 57','x','y');
xlower =-7;
xupper = 9;
tol = 10^(-3);


value8 = muller_diff(f3,4.5,5.5,5)