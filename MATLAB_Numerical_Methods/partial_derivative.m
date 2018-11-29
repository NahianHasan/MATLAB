function [X,Y,X2,Y2,XY] = partial_derivative(f,x,y,hx,hy)
%f = function of both variables x and y
%X,Y = Partial derivative value at the point (x,y) w.r.t. x and y
%      respectively
%X2,Y2 = Partial 2nd order derivative value at the point (x,y) w.r.t. x and y
%      respectively
%XY = partial 2nd order Derivative value with respect to x and y at the point (x,y)
%hx,hy = divided difference along x and y direction

    X = (f(x+hx,y) - f(x-hx,y))/(2*hx);
    Y = (f(x,y+hy) - f(x,y-hy))/(2*hy);
    
    XY = (f(x+hx,y+hy) - f(x+hx,y-hy) - f(x-hx,y+hy) + f(x-hx,y-hy))/(4*hx*hy);
    X2 = (f(x+hx,y) - 2*f(x,y) + f(x-hx,y))/(hx*hx);
    Y2 = (f(x,y+hy) - 2*f(x,y) + f(x,y-hy))/(hy*hy);
end

