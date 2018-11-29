clear all
close all
clc

format long

f = inline('sin(cos(1/x))','x');
f_exact = inline('(1/(x.^2))*sin(1./x)*cos(cos(1./x))','x');
Value = [];

for x= -1:0.01:1
    h = [];h1 = 1;
    error = [];
    exact = f_exact(x);

    X =[];
    for i =1:3
        h1 = 1/(10^i);
        h = [h h1];
        val = central_difference(f,x,h1,1,2);
        X = [X val];
        error = [error (val-exact)];
    end

    cp = X(1);
    c  = X(2);
    cn = X(3);

    i = 4;
    while(abs(cn-c)<= abs(c-cp))
        h1 = 1/(10^i);
        h = [h h1];
        val = central_difference(f,x,h1,1,2);
        error = [error (val-exact)];
        X = [X val];
        cp = X(i-2);
        c = X(i-1);
        cn = X(i);
        i = i+1;
    end
    Value = [Value X(end-1)];
end


x1 = -1:0.01:1;
y = sin(cos(1./x1));
plot(x1,y)

figure
plot(x1,Value)








