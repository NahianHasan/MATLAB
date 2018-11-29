function sum = lagrange3(x,y)

    n = length(x);
    sum = 0;
    
    for i = 1:n
        num = 1;
        den = 1;
        for j = 1:n
            if (i~= j)
                num = conv(num,poly(x(j)));
                den = den * (x(i) - x(j));
            end
        end
            c = num / den;
            c1 = c* y(i);
            sum = sum + c1;
      
    end

end

