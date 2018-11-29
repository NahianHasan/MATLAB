delete curvedr.txt;
diary curvedr.txt;
echo on;
clear all;
close all;
s = ratul(2,4);
x = 2*pi*[0:0.01:1];
hold on;
for c = 1:s
    plot(x,sin(c*x))
    pause
    echo off;
end
echo on;

hold off;
title('Several Sine curves')
echo off;
diary off;



