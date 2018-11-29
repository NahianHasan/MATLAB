function [I2, h] = adaptive_integration(x1,x2,e)
    
    format long;
    f = inline('x.*exp(-2*x.^2)','x');

    h = (x2-x1)/2;
    I1 = (f(x1) + f(x2))/2;
    I1 = I1 + f(x1 + h);
    I1 = I1*h;
    
    i=2;
    h = h/2;
    I2 = (f(x1) + f(x2))/2;
    for j = 1:(2^i - 1)
        I2 = I2 + f(x1 + j*h);
    end
    I2 = I2*h;
    
    i = 3;
    H = [];
    E = [];
   
    while (abs(I2-I1) >= e*abs(I2))
        p = abs(I2-I1);
        E = [E p];
        H = [H h];
        I1 = I2;
        h = h/2;
        I2 = (f(x1) + f(x2))/2;
        for j = 1:(2^i - 1)
            I2 = I2 + f(x1 + j*h);
        end
        I2 = I2*h;
        i = i+1;
    end

    plot(E,H)
end

