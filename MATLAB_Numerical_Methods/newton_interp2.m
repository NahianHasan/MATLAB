function sum = newton_interp2(x,y)

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
        coeff = 1;
        for j = 1:i-1
            coeff = conv(coeff,poly(x(j)));
        end
        coeff = coeff * d(i);
        
        for k = 1:n-i
            coeff = [0 coeff];
        end
        
        sum = sum + coeff;
        
    end
    
    s = d(1);
    for k = 1:n-1
        s = [0 s];
    end
    
    sum = sum+s;

end

