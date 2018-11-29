function value = trapezoidal(f,x1,x2,h)

    value = (((f(x1) + f(x2))/2) + sum(f(x1+h:h:x2-h)))*h;

end

