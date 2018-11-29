clear all
close all
clc

x = input('Enter the sample data x:');
y = input('Enter the sample data y:');

B = quadratic_spline(x,y);

l = min(x(:));
h = max(x(:));

u = (h - l) / 200;

Y = [];
for i = l:u:h
    flag = 0;
    for j = 1:length(x)-1
        if ((i <= x(j+1) && i >= x(j)))
            flag = 1;
            break;
        end
    end
    if flag == 1
        c = B(1,j)*i*i + B(2,j)*i + B(3,j);
        Y = [Y c];
    else
        continue;
    end

end
s = l:u:h;
plot(s,Y,x,y,'*');
grid on;
axis tight;