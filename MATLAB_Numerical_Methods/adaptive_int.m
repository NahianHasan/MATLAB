function value = adaptive_int(f,x1,x2,e)

    h = (x2-x1)/2;
    I1 = (((f(x1) + f(x2))/2) + sum(f(x1+h:h:x2-h)))*h;
    
    h = h/2;
    I2 = (((f(x1) + f(x2))/2) + sum(f(x1+h:h:x2-h)))*h;
    
    E = [];
    H = [];
    while(abs(I2-I1) >= e)
        P = abs(I2-I1);
        E = [E P];
        H = [H h];
        I1 = I2;
        h = h/2;
        I2 = (((f(x1) + f(x2))/2) + sum(f(x1+h:h:x2-h)))*h;
    end
    value = I2;
    plot(H,E)
end

