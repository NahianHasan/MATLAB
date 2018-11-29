function B = multiple_linear_regression(x,y,n)

    %x    =    multiple independent variable sample matrix each column of
    %          which is the values of a single variable
    %y    =    sample values of the dependent variable
    %n    =    number of independent variables
    %B    =    Regression Cooefficients as b0,b1,b2,b3 etc in a single row
    X = zeros(n+1,n+1);
    X(1,1) = length(x(:,1));
    for i = 2:n+1
        c = x(:,i-1)' * x(:,i-1);
        X(i,i) = c;
    end
    
    for i = 1:n
        if i==1
            c = sum(x,1);
            X(i+1:end,i) = c';
        elseif i>1
            for j=i:n
                c = x(:,j)' * x(:,i-1);
                X(j+1,i) = c;
            end
        end
    end
    X
    X1 = X';
    for i = 1:n
        X1(i,i) = 0;
    end
    final_X = X+X1
    
    Y = zeros(n,1);
    Y(1,1) = sum(y(:));
    for i = 2:n+1
        Y(i,1) = y(1,:) * x(:,i-1);
    end
    
    final_X = [final_X Y];
    B = Gauss_Jordan(final_X) 
end

