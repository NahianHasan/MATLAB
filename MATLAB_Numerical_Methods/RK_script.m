clear all
close all

f = inline('-2.*(x.^3)+12.*(x.^2)-20.*x+8.5','x','y');
f1 = inline('4.*exp(0.8.*x) - 0.5.*y','x','y');
xi = 0;
yi = 2;
xf = 4;
h = 0.5;


[X,Y] = RK_2(f1,0.5,0.5,1,1,h,xi,yi,xf);%heun's method
plot(X,Y);
hold on;
[X,Y] = RK_2(f1,0,1,0.5,0.5,h,xi,yi,xf);%Midpoint Method
plot(X,Y);
[X,Y] = RK_2(f1,1/3,2/3,3/4,3/4,h,xi,yi,xf);%Ralston's Method
plot(X,Y);
[X,Y] = RK_3(f1,1/6,2/3,1/6,0.5,0.5,1,-1,2,h,xi,yi,xf);%3rd order RK
plot(X,Y);
[X,Y] = RK_4(f1,1/6,1/3,1/3,1/6,0.5,0.5,0.5,0,0.5,1,0,0,1,h,xi,yi,xf);
plot(X,Y);
[X,Y] = RK_5_butcher(f1,7/90,0,16/45,2/45,16/45,7/90,0.25,0.25,0.25,1/8,1/8,0.5,0,-0.5,1,3/4,...
    3/16,0,0,9/16,1,-3/7,2/7,12/7,-12/7,8/7,h,xi,yi,xf);
plot(X,Y);
legend('Heuns Method','Midpoint Method','Ralstons Method','3rd Order RK','4th Order RK','5th Order RK-Butcher');
hold off
grid on