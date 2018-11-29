function Y = gauss_seidel2(A,b)

    [m,n] = size(A);
    X = zeros(1,n);
    Y = zeros(1,n);
    
    for i = 1:m
        f = abs(A(i,i)) > (sum(abs(A(i,:))) - abs(A(i,i)));
        if f == 0
            disp('Not diagonally dominant');
            return;
        end
    end
        
    while(1)
        for i = 1:n
            L = 0;
            if(i > 1)
                L = A(i,1:i-1) * (X(1:i-1))';
            end
            H = A(i,(i+1):n) * (X(i+1:n))';
            C = L + H;
            C1 = b(i) - C;
            X(i) = C1/A(i,i);
        end
        
        flag = 1;
        for i = 1:n
            if(abs(abs(Y(i)) - abs(X(i))) > 0.0001)
                flag = 0;
                break;
            end
        end
        
        if flag == 1
            break;
        elseif flag == 0
            Y = X;
        end
    end

end

