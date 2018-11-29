clear all
clc
close all

x = (1-sqrt(5))/2;
m = richardson(x);

f = inline('cos(x.^3 - 7*x.^2 + 6*x + 8) * (3*x.^2 - 14*x + 6)','x');
disp('The approximate result of the derrivative is: ');
m
disp('The total error with the accurte result is: ')
error = f(x) - m


