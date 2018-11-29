
clc
clear all
close all
x = [0,1,2,3,4,5,6];
y = [0,0.8415,0.9093,0.1411,-0.7568,-0.9589,-0.2794];
P = lagrange(x,y);

Y = [];
for i = 0:0.10:6
    c = polyval(P,i);
    Y = [Y c];
end

s = 0:0.10:6;
plot(s,Y,x,y,'*');
title('Interpolation by newton polynomial method using data points marked by *');
xlabel('x');
ylabel('y');
legend('Newton Interpolation','Linear Interpolation');