function A = n_order_regression3(x,y,n)

    m = length(x);
    X = [];
    for i = 1:2*n - 1
        c = x(:);
        for j = 1:i
            c = c .* x(:);
        end
        c1 = sum(c(:));
        X = [X c1];
    end
    
    X = [m sum(x(:)) X];
    
    Y =[];
    for i = 1:n-1
        c = x(:) .* y(:);
        for j = 1:i
            c = c.* x(:);
        end
        c1 = sum(c(:));
        Y = [Y c1];
    end
    Y = [sum(y(:)) sum(x(:).*y(:)) Y];
    
    D = zeros(n+1,n+1);
    for i = 1:n+1
        for j = 1:n+1
            D(i,j) = X(i+j-1);
        end
    end
    
    inv_D = inv(D);
    A = inv_D * Y';
end

