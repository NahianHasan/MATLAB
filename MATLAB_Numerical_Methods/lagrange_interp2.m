function sum = lagrange_interp2(x,y)

    n = length(x);
    sum = 0;
    for i = 1:1:n
        den = 1;
        num = 1;
        for j = 1:1:n
            if(j~=i)
                num = conv(num,poly(x(j)));
                den = den*(x(i) - x(j));
            end
        end
        
        coeff = num/den;
        coeff = coeff * y(i);
        sum = sum + coeff;
    end
end

