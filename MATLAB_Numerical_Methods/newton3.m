function sum = newton3(x,y)

    n = length(x);
    D = zeros(n,n);
    D(:,1) = y';
    
    for i = 2:n
        for j = i:n
            D(j,i) = (D(j,i-1) - D(j-1,i-1))/(x(j) - x(j-i+1));
        end
    end
    
    d = diag(D);
    
    sum = 0;
    
    for i = 2:n
        c = 1;
        for j = 1:i-1
            c = conv(c,poly(x(j)));
        end
        c = c*d(i);
        
        for k = 1:n-i
            c = [0 c];
        end
        sum = sum + c;
    end
    
    s = d(1);
    for i = 1:n-1
        s = [0 s];
    end
    
    sum = sum + s;

end

