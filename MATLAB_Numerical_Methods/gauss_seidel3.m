function Y = gauss_seidel3(A,b)

    [m,n] = size(A);
    X = zeros(1,n);
    Y = zeros(1,n);
    
    while(1)
        for i = 1:n
            L = 0;
            if i>1
                for j = 1:i-1
                    L = A(i,1:i-1) * (X(1:i-1))';
                end
            end
            H = A(i,i+1:n) * (X(i+1:n))';
            C = L + H;
            C1 = b(i) - C;
            x = C1/A(i,i);
            X(i) = x;
        end

        flag = 1;
        for i = 1:n
            if (abs(abs(Y(:)) - abs(X(:))) > 0.000001)
                flag = 0;
                break;
            end
        end

        if flag == 1
            break;
        else
            Y = X;
        end
    end
end

