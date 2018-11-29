function [m err relerr] = richardson(x)
    %delta    =    tolerence for error
    %toler    =    tolerence for relative error
    %D        =    Matrix of approximate derrivatives
    %err      =    error bound
    %relerr   =    relative error bound
    %x        =    The point where the derrivative is to be calculated
    %m        =    Best Approximation;
    
    format long;
    err = 1;
    relerr = 1;
    h = 1;
    j = 1;
    toler = 0.0000000000001;
    delta = 0.0000000000001;
    
    f = inline('sin(x.^3 - 7*x.^2 +6*x + 8)', 'x');
    
    D(1,1) = (f(x+h) - f(x-h))/(2*h);
    
    while ((relerr > toler) & (err>delta) & (j<12))
        h = h/2;
        D(j+1,1) = (f(x+h) - f(x-h))/(2*h);
        
        for k = 1:j
            D(j+1,k+1) = D(j+1,k) + (D(j+1,k) - D(j,k))/((4^k)-1);
        end
        
        err = abs(D(j+1,j+1) - D(j,j));
        relerr = (2*err) / ((abs(D(j+1,j+1))) + abs(D(j,j)) + eps);
        j = j+1;
    end
    [n,n] = size(D);
    m = D(n,n);
    disp('The best approximation result is: ')
end
