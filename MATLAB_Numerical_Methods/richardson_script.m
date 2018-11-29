clear all
close all
clc

format long

f = inline('sin(x.^3 - 7*x.^2 + 6.*x + 8)','x');
f_exact = inline('cos((x.^3) - 7*(x.^2) + 6*x + 8)*(3*(x.^2) - 14*x + 6)', 'x');
f1 = inline('sin(x)','x');
f2 = inline('cos(x)','x');
h = 0.000001;
tol = 0.0000000000000001;
delta = 0.0000000000000001;
Y = [];
for x = 0:0.01:6
    value = richardson_extrap(f1,x,h,tol,delta);
    Y = [Y value];
end

i = 0:0.01:6;
y = f1(i);
y1 = f2(i);
plot(i,y,i,Y,i,y1)
legend('Main Function','Richardson','Original_Richardson');