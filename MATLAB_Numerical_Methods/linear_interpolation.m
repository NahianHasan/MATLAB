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
        c = ((i - x(j+1))/ (x(j) - x(j+1))) * y(j) - ((i - x(j)) / (x(j) - x(j+1))) * y(j+1);
        Y = [Y c];

end
s = 0:0.1:6
plot(s,Y,x,y,'*');
grid on;
axis tight;