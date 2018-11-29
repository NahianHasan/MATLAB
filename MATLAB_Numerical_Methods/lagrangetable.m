clear all
clc

x = [0, 1, 2, 3, 4, 5, 6];
y = [0, 0.8415, 0.9093, 0.1411, -0.7568, -0.9589, -0.2794];

Y = [];
for i = 0:0.25:6
    c = lagrange(x,y,i);
    Y = [Y c];
end

s = 0:0.25:6;
plot(s,Y);
hold on;
plot(s,Y,'o');
hold on;
plot(x,y,'*');
hold off;
figure;
plot(x,y);