clear all
close all
clc

f = @(x,y) exp(2*x - y);

del_x = input('del_x for the x direction: ');
del_y = input('del_y for the y direction: ');

integral_value = double_integral(0,3,0,3,del_x,del_y)

original = integral2(f,0,3,0,3);
error = abs(abs(original) - abs(integral_value));
error_percentage = error / abs(original);
error_percentage = error_percentage * 100