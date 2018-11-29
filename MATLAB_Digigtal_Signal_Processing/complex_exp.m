function [y,n] = complex_exp(sigma,w,n1,n2)

    n = n1:n2;
    y = exp((sigma+w*i)*n);

end

