clear all
close all
clc

n1 = -3;
n2 = 3;
n =n1:n2;
n0 = -1;

%Unit Impulse
x1 = [(n-n0) == 0]
figure
stem(n,x1)
axis([-4 4 -1 2]);

%Unit Step
x2 = [(n-n0) >= 0]
figure;
stem(n,x2)
axis([-4 4 -1 2])

%Unit ramp
x4 = (n-n0).*[(n-n0)>0]
figure;
plot(n,x4)
axis([-4 4 -1 5])


%exponential sequence
x5 = 2.^n;
figure;
stem(n,x5)

%compllex_valued exp
x6 = exp((2+3i).*n);
figure;
stem(n,x6)

%shift
k=3
m=n+k;
x7 = x2;
figure;
stem(m,x7)
axis([-4 8 -1 2])

%sample summation
x8 = sum(x2(:))


%signal energy
%x9 = sum(x2.* conj(x2))
x10 = sum(abs(x7).^2)