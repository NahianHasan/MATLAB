function Y = jacobi(A,b)
    
    [m,n] = size(A);
    
    X = zeros(1,n);
    Y = zeros(1,n);
    
    while (1)
        for i = 1:n
            L = 0;
            if (i > 1)
                P = A(i,1:i-1).* X(1:i-1);
                L = sum(P);
            end
            
            Q = A(i,(i+1):n).* X((i+1):n);
            H = sum(Q);
        
            C = L + H;
            C1 = (b(i) - C) / A(i,i);
            
            X(i) = C1;
        end
        
        flag = 1;
        for i = 1:n
            if (abs(abs(Y(i)) - abs(X(i))) > 0.00000001)
                flag = 0;
                break;
            end
        end
        
        if (flag == 1)
            break;
        elseif (flag == 0)
            Y = X;
        end        
    end

end

