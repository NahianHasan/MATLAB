clear all
close all
clc

x = input('X:');
y = input('Y:');

P = newton3(x,y);
Y = [];

for i = x(1):0.1:x(end)
    y1 = polyval(P,i);
    Y = [Y y1];
end

s = x(1):0.1:x(end);
plot(s,Y,x,y,'*r');