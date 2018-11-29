clear all
close all
clc

x = [1,1,0,0,1];
N = 10;
L = length(x);
x = [x zeros(1,N-L)];
n = length(x);
n = 0:N-1;
k = 0:N-1;
Wn = exp(-j*2*pi/N);
WN = Wn.^(n'*k);
X= WN*x';
subplot(2,1,1);
stem(k/N,abs(X))