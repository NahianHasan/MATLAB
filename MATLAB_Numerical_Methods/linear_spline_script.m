clear all
close all
clc

x = input('Enter the sample data x:');
y = input('Enter the sample data y:');

m = linear_spline(x,y);

l = min(x(:));
h = max(x(:));

u = (h - l) / 200;

Y = [];
for i = 0:0.1:6
    flag = 0;
    for j = 1:length(x)-1
        if ((i <= x(j+1) && i >= x(j)))
            flag = 1;
            break;
        end
    end
        c = y(j) + m(j) * (i - x(j));
        Y = [Y c];

end
s = 0:0.1:6
plot(s,Y,x,y,'*');
grid on;
axis tight;