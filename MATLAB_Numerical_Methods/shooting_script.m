clear all
close all
clc

f = inline('0.01.*(T-20)','x','y','T');
Q = linear_shooting(f,0.1,0,10,10,40,200,0.001)