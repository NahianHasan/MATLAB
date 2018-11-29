function x  = Gauss_Jordan(A)
    %A is an augmented matrix
    [m,n] = size(A);%m = number of equations, n = number of unknowns
    D = A(:,:);
    
    for j = 1:m-1
        %%pivotong
        C = D(j:end,j);
        [C1,idx] = max(abs(C));
        if (idx ~= 1)
            idx = idx + j -1;
            t = D(j,:);
            D(j,:) = D(idx,:);
            D(idx,:) = t;
        end
        %%Triangularization
        for i = 1:m-j
            D(i+j,:) = D(i+j,:) - ((D(j,:) / D(j,j)) * (D(i+j,j)));
        end
    end
    
    %%Solution Phase 
    x = zeros(1,n-1);
    x(n-1) = D(m,n) / D(m,n-1);
    
    for i = n-1:-1:1
        sum = 0;
        for j = i+1:n-1
            sum = sum + D(i,j) * x(j);
        end
        x(i) = (D(i,n) - sum) / D(i,i);
    end
 
end

