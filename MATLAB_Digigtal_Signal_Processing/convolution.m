clear all
close all
clc

x1 = [4 2 6 3 8 1 5];
x2 = [3 8 6 9 6 7];
n1 = [-2:4];
n2 = [-4:1];
kmin = min(n1) + min(n2);
kmax = max(n1) + max(n2);
y = conv(x1,x2);
k = kmin:kmax
m1 = zeros(1,length(k))
m2 = m1

m1(find((k >= min(n1)) & (k <= max(n1)) == 1)) = x1;
m2(find((k >= min(n2)) & (k <= max(n2)) == 1)) = x2;
subplot(2,2,1),stem(k,m1);
subplot(2,2,2),stem(k,m2);
subplot(2,2,3),stem(k,y);