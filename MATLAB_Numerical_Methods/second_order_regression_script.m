clear all
clc
x = [0,1,2,3,4,5];
y = [2.1,7.7,13.6,27.2,40.9,61.1];

[a0,a1,a2] = second_order_regression(x,y);
Y = [];
for i = 1:0.1:20
    c = a0 + a1 * i + a2 * i * i;
    Y = [Y c];
end

[A1,A0] = linear_regression(x,y);
Y1 = [];
for i = 1:0.1:20
    c = A0 + A1 * i;
    Y1 = [Y1 c];
end

s = 1:0.1:20;
plot(s,Y,s,Y1,x,y,'*');
legend('Second_order_regression','Linear_regression Line','Data Points');