function A = n_order_regression(x,y,m)
     % A function for creating an m-order regression model
     %X = a vector containing the necessary elements of summation of specific
     %powers of x
     %Y = a vector containing the necessary elements of summation of specific
     %powers of y and other constants on the right side of normal equations after derrivative 
     % A = vector containing regression coefficients such as a0, a1, a2,
     % a3, ...
    n = length(x);
    
    %%
    X = [];
    for i = 1:2*m-1
        c = x(:);
        for j = 1:i
            c = c .* x(:);
        end
        c1 = sum(c(:));
        X = [X c1];
    end
    
    X = [n sum(x(:)) X];
    %%
    
    %%
    Y = [];
    for i = 1:m-1
        c = x(:).*y(:);
        for j = 1:i
            c = c.* x(:);
        end
        c1 = sum(c(:));
        Y = [Y c1];
    end
    
    Y = [sum(y(:)) sum(x(:).*y(:)) Y];
    %%
    X
    D = zeros(m+1,m+1);
    
    M = size(D,1);
    
    for i = 1:M
        for j = 1:M
            D(i,j) = X(j+i-1);
        end
    end
    
    D_inv = inv(D);
    A = D_inv*Y';
    %%
   
end

