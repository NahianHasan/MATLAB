function [X,Y] = newton_raphson_system(u,v,x,y,tol)
    
    [ux,uy,x2u,y2u,xyu] = partial_derivative(u,x,y,0.001,0.001);
    [vx,vy,x2v,y2v,xyv] = partial_derivative(v,x,y,0.001,0.001);
    X = x - (u(x,y)*vy - v(x,y)*uy)/(ux*vy - uy*vx);
    Y = y - (v(x,y)*ux - u(x,y)*vx)/(ux*vy - uy*vx);
    
    iter = 1;
    for i = 1:1000
        if(abs(X-x) > tol | abs(Y-y) > tol)
            x = X;
            y = Y;
            iter =iter +1;
            [ux,uy,x2u,y2u,xyu] = partial_derivative(u,x,y,0.001,0.001);
            [vx,vy,x2v,y2v,xyv] = partial_derivative(v,x,y,0.001,0.001);
            X = x - (u(x,y)*vy - v(x,y)*uy)/(ux*vy - uy*vx);
            Y = y - (v(x,y)*ux - u(x,y)*vx)/(ux*vy - uy*vx);
        end
    end
end

