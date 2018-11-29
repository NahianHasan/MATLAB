clear all
close all
clc

x = @(t)(sin(0.36*t));
fs = 1;
L = 3;
t1 = 1:1/fs:52;
x1 = x(t1);
stem(t1,x1);
t2 = t1/L;
x2 = x(t2);
figure;
stem(t1,x2);