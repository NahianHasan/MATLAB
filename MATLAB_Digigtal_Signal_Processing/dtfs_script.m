clear all
close all
clc

L = 5;
N = 300;
k = [-N/2:N/2];
xn = [ones(1,L), zeros(1,N-L)];
Xk = dtfs(xn,N);
numel(Xk)
subplot(2,1,1);
mag = [Xk(N/2+1:N) Xk(1:N/2+1)];
stem(k,mag);
subplot(2,1,2);
mag = abs([Xk(N/2+1:N) Xk(1:N/2+1)]);
stem(k,mag);