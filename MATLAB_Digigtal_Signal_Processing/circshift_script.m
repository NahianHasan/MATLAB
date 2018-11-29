clear all
close all
clc

x1 = [1 2 3 4 5];
x2 = [6 7 8 9 10];

W = [];
for i=0:length(x2)-1
    k = circshift(x2,i,length(x2));
    W = [W k'];
end
Y = W*x1'