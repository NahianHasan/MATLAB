clc
clear all
close all
T=2/1000;
tstep=T/100;
x=@(t)(sin(2*pi*t/T))
t=tstep:tstep:T;
plot(t,x(t))
z=x(t);
[ACF,n]=conv_m(z,t,fliplr(z),-fliplr(t))
stem(ACF)

