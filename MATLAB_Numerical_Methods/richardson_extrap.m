function [result] = richardson_extrap(f,x,h,tol,delta)
    format long
    
    D = [];
    error = 1;
    rel_error = 1;
    D(1,1) = (f(x+h) - f(x-h))/(2*h);
    m = 2;
    while((error>tol) & (rel_error>delta))
        D(m,1) = (f(x+(2^(m-1))*h) - f(x-(2^(m-1))*h))/((2^m)*h);

        for k = 2:m
            D(m,k) = D(m,k-1) + (4^k)*((D(m-1,k-1) - D(m,k-1))/((4^k) - 1));
        end
        
        error = abs(D(m,m) - D(m-1,m-1));
        rel_error = (2*error) / (abs(D(m,m)) + abs(D(m-1,m-1)) + eps);
        
        m = m+1;
    end
    result = D(m-1,m-1);
    
end

