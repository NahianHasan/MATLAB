clear all
close all
clc

x = input('X:');
f = inline('sin(cos(1/x))','x');
h = [];h1 = 1;
error1 = [];
error2 = [];
error3 = [];
exact = f(x);
for i = 1:10
    h1 = h1/(10^i);
    h = [h h1];
    val1 = forward_difference(f,x,h1,1,2);
    error1 = [error1 (val1-exact)];
    val2 = central_difference(f,x,h1,1,1);
    error2 = [error2 (val2-exact)];
    val3 = central_difference(f,x,h1,1,2);
    error3 = [error3 (val3-exact)];
end
plot(h,error1,h,error2,h,error3);
legend('Forward Difference','Central Difference_2','Central Difference_4');
xlabel('h');
ylabel('Error')