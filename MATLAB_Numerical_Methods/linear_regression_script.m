clear all
clc
x = [1,2,3,4,5,6,7];
y = [.5,2.5,2.0,4,3.5,6,5.5];

[a1,a0] = linear_regression(x,y);
Y = [];
for i = 1:0.1:20
    c = a0 + a1 * i;
    Y = [Y c];
end

s = 1:0.1:20;
plot(s,Y,x,y,'*');
legend('regression Line', 'Data Points');