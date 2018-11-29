function xkplus1 = secant_modified_multiple(f,xk,xkminus1,tol)
    
    s = -10:0.1:10;
    y = f(s);
    
    u = f(xk) / forward_difference(f,xk,0.001,1,2);
    v = f(xkminus1) / forward_difference(f,xkminus1,0.001,1,2);
    xkplus1 = xk - (u*(xkminus1-xk))/(v - u);
    
    iter = 1;
    for i = 1:100
        if(abs(xkplus1 -xk) > tol)
            xk = xkminus1;
            xkminus1 = xkplus1; 
            u = f(xk) / forward_difference(f,xk,0.001,1,2);
            v = f(xkminus1) / forward_difference(f,xkminus1,0.001,1,2);
            xkplus1 = xk - (u*(xkminus1-xk))/(v - u);
        end
    end
end

