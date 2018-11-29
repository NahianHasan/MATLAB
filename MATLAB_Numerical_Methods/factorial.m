function f = factorial(n)
    if ((n < 0) | (ceil(n) ~= n))
        disp('The input must be a positive integer');
    elseif (n == 0)
        f = 1;
    else
        prod = 1;
        for i = 1:1:n
            prod = prod * i;
        end
        f = prod;
    end
end

