function x = LU_decomp(A,b)
    %L = lower triangular matrix
    %U = Upper triangular matrix
    
    [m,n] = size(A);%m = number of equations, n = number of unknowns
    U = A(:,:);
    K = ones(1,n);
    L = diag(K);
    for j = 1:m-1
        for i = 1:m-j
            L(i+j,j) = U(i+j,j) / U(j,j);
            U(i+j,:) = U(i+j,:) - ((U(j,:) / U(j,j)) * (U(i+j,j)));
        end
    end

    y = (zeros(1,n));
    y(1) = b(1);
    
    for i = 2:n
        y(i) = b(i) - L(i,1:i-1)*y(1:i-1)';%analyze this line.This is very very important
    end

    b = y;
    
    x = zeros(1,n);
    x(n) = b(n) / U(n,n);
    for k = n-1:-1:1
        x(k) = (b(k) - U(k,k+1:n)*x(k+1:n)') / U(k,k);
    end

    
    
end

