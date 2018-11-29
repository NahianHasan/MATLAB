function x = gauss_jordan3(A)

    [m,n] = size(A);
    
    for i = 1:m-1
        column = A(i:end,i);
        [val,idx] = max(column(:));
        if (idx ~= 1)
            idx = idx + i -1;
            temp = A(i,:);
            A(i,:) = A(idx,:);
            A(idx,:) = temp;
        end
        
        for j = i+1:m
            A(j,:) = A(j,:) - (A(i,:)/A(i,i)) * A(j,i);
        end
    end
    
    x = zeros(1,n-1);
    x(n-1) = A(m,n)/A(m,n-1);
    for i = n-2:-1:1
        sum  = 0;
        for j = i+1:n-1
            sum = sum + A(i,j) * x(j);
        end
        x(i) = (A(i,n) - sum)/A(i,i);
    end
end

