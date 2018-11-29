function [greg_newton] = gregory_newton_forward_interp(x,y)

    M = length(x);
    GN = zeros(M,M);
    GN(:,1) = y';
    
    for j = 2:M
        for i = j:M
            GN(i,j) = GN(i,j-1) - GN(i-1,j-1);
        end
    end
    D = diag(GN);
    
    r = poly(x(1)) / (x(2) - x(1));
    sum = 0;
    for i = 1:M-1
        c = poly(x(1)) / (x(2) - x(1));
        for j = 0:i-1
            p = [0 j];
            p1 = r - p;
            if (j == 0)%It's because there's no r^2 term.
                continue;
            end
            c = conv(c, p1);
        end
        d = c / factorial(i);
        d1 = d*D(i+1);
        for k = 1:M-i-1%padding with zeros to add the polynomials
            d1 = [0 d1];
        end
        sum = sum + d1;
    end
    
    s = D(1);
    for k = 1:M-1
       s = [0 s];
    end
    
    greg_newton = sum + s;
    
end

