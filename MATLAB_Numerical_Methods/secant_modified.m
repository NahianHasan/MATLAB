function xkplus1 = secant_modified(f,xk,delta,tol)
    
    s = -10:0.1:10;
    y = f(s);
    
    xkplus1 = xk - ((delta*xk*f(xk))/(f(xk+delta*xk)-f(xk)));
    X = [xk xkplus1];
    Y = [f(xk) 0];
    
    iter = 1;
    for i = 1:100
        if(abs(xkplus1 -xk) > tol)
        xk = xkplus1;
        xkplus1 = xk - ((delta*xk*f(xk))/(f(xk+delta*xk)-f(xk))); 
        Y = [f(xk) 0];
        end
    end
end

