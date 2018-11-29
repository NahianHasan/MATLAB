function value = simpson_1_3(f,x1,x2,h)
    
    value = 0;
    while(x1 < x2)
        value = value + (h/3)*(f(x1) + 4*f(x1+h) + f(x1+2*h));
        x1 = x1 + 2*h;
    end

end

