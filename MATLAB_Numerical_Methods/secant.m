function xkplus1 = secant(f,xk,xkminus1,tol)
    
    s = -10:0.1:10;
    y = f(s);
    plot(s,y);
    hold on
    
    xkplus1 = xkminus1 - ((f(xkminus1)*(xk - xkminus1))/(f(xk) - f(xkminus1)));
    X = [xk xkplus1];
    Y = [f(xk) 0];
    line(X,Y)
    
    iter = 1;
    for i = 1:100
        if(abs(xkplus1 -xk) > tol)
        xk = xkminus1;
        xkminus1 = xkplus1;
        xkplus1 = xkminus1 - ((f(xkminus1)*(xk - xkminus1))/(f(xk) - f(xkminus1)));
        X = [xk xkplus1];
        Y = [f(xk) 0];
        line(X,Y)
        end
    end
    hold off
end

