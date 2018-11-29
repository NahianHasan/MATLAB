function x3 = muller_diff(f,x0,x1,x2)

    iter = 1;
    for i = 1:100;
        h0 = x1 - x0;
        h1 = x2 - x1;
        del0 = (f(x1) - f(x0))/(x1 - x0);
        del1 = (f(x2) - f(x1))/(x2 - x1);
        a = (del1 - del0)/(h1 + h0);
        b = a*h1 + del1;
        c = f(x2);
        iter = iter + 1;
        
        rad = sqrt(b*b - 4*a*c);
        if(abs(b+rad) > abs(b-rad))
            den = b+rad;
        else
            den = b - rad;
        end

        dxr = -2*c / den;
        x3 = x2 + dxr;
        
       
        if(abs((x3-x2)/x3)*100 < 0.0000000000000001)
            break;
        end
        x0 = x1;
        x1 = x2;
        x2 = x3;
        
    end
    iter
end

