function sum = lagrange(x,y)

        n = length(x);
    
       sum = 0;
        for k = 1:n
            coeff = 1;
            r = 1;
            for i = 1:1:n
                if (i ~= k)
                  
                
                coeff = coeff * (x(k) - x(i));
                r = conv(r,poly(x(i)));
  
                end
            end
            c = r/coeff;
            c = conv(c, y(k));
            sum = sum + c;
        end
end

