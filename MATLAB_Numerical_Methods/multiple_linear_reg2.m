function B = multiple_linear_reg2(x,y,n)

    X = zeros(n+1,n+1);
    X(1,1) = length(x(:,1));
    
    for i = 2:n+1
        X(i,i) = x(:,i-1)' * (x(:,i-1));
    end
    
    for i = 1:n+1
        if(i == 1)
            for j = i+1:n+1
                X(j,i) = sum(x(:,j-1));
            end
        elseif i>1
            for j = i+1:n+1
                X(j,i) = (x(:,i-1))' * (x(:,j-1));
            end
        end
    end
    X
    X1 = X';
    for i = 1:n+1
        X1(i,i) = 0;
    end
    
    final_X = X + X1
    
    Y = zeros(n+1,1);
    Y(1,1) = sum(y(:));
    for j = 2:n+1
        Y(j) = y(1,:) * x(:,j-1);
    end
    
    f = [final_X Y];
    B = gauss_jordan2(f)
    

end

