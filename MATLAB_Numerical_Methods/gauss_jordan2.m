function x = gauss_jordan2(A)

    [m,n] = size(A);
    
    for i = 1:1:m-1
        column1 = A(i:end,i);
        [val,idx] = max(abs(column1(:)));
        if (idx ~= 1)
            idx = idx + i-1;
            temp = A(i,:);
            A(i,:) = A(idx,:);
            A(idx,:) = temp;
        end
        
        for j = i+1:m
            A(j,:) = A(j,:) - (A(i,:) ./ A(i,i)) .* A(j,i);
        end
    end
        
    x = zeros(1,n-1);
    x(end) = A(m,n)/A(m,n-1);
    
    for i = n-2:-1:1
        c1 = 0;
        for j = i+1:n-1
            c1 = c1 + x(j)*A(i,j);
        end
        c = (A(i,n) - c1) / A(i,i);
        x(i) = c;
    end
end

