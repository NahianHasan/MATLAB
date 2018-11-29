clear all
close all
clc

[x1,n1] = stepseq(0,-5,45);
[x2,n2] = stepseq(10,-5,45);
[x,nx] = sigadd(x1,-x2,n1,n2);
subplot(2,2,1);
stem(nx,x)
h = (0.9.^nx).*x1;
nh = nx;
subplot(2,2,2);
stem(nh,h);
axis([-5,45,0,2])
[y,n] = my_conv(x,nx,h,nh);
subplot(2,2,3);
stem(n,y)
