clear all
close all
clc

format long;

f = inline('-2.*(x.^3)+12.*(x.^2)-20.*x+8.5','x','y');
f1 = inline('4.*exp(0.8.*x) - 0.5.*y','x','y');
s = 0:0.01:4;
plot(s,f(s,1));
hold on;
xi = 0;
yi = 2;
xf = 4;

[X,Y] = RK_4_adaptive(f,1/6,1/3,1/3,1/6,0.5,0.5,0.5,0,0.5,1,0,0,1,xi,yi,xf,0.00001);
plot(X,Y);
[X,Y] = RK_4(f,1/6,1/3,1/3,1/6,0.5,0.5,0.5,0,0.5,1,0,0,1,0.5,xi,yi,xf);
plot(X,Y);
[M,N,N1] = RK_Fehlberg(f,xi,yi,xf,0.000000001);
plot(M,N);
legend('original Diff. Eqn','Adaptive','RK-4','RK-Fehlberg Solution');
grid on
hold off;