function value = simpson_3_8(f,x1,x2,h)
    
    value = 0;
    while(x1 < x2)
        value = value + (h/3)*(f(x1) + 3*f(x1+h) + 3*f(x1+2*h) + f(x1+3*h));
        x1 = x1 + 3*h;
    end

end

