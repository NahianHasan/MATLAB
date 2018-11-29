function value = central_difference(f,x,h,o,i)
%f = derivative function
%x = the value at which the derivative has to be evaluated
%h = divided difference
%o = Order of the derivative
%i = takes the values either 1 or 2; 2 denotes more accurate results

    if(o == 1 & i == 1)
        value = (f(x+h)-f(x-h))/(2*h);
    elseif(o == 1 & i == 2)
        value = (-f(x + 2*h) + 8*f(x+h) - 8*f(x-h) + f(x-2*h))/(12*h);
    elseif(o == 2 & i == 1)
        value = (f(x+h)-2*f(x)+f(x-h))/(h*h);
    elseif(o == 2 & i == 2)
        value = (-f(x+2*h) + 16*f(x+h) - 30*f(x) + 16*f(x-h) - f(x-2*h))/(12*h*h);
    elseif(o == 3 & i == 1)
        value = (f(x+2*h) - 2*f(x+h) + 2*f(x-h) - f(x-2*h))/(2*(h^3));
    elseif(o == 3 & i == 2)
        value = (-f(x+3*h) + 8*f(x+2*h) - 13*f(x+h) + 13*f(x-h) - 8*f(x-2*h) + f(x-3*h))/(8*(h^3));
    elseif(o == 4 & i == 1)
        value = (f(x+2*h) - 4*f(x+h) + 6*f(x) - 4*f(x-h) + f(x-2*h))/(h^4);
    elseif(o == 4 & i == 2)
        value = (-f(x+3*h) + 12*f(x+2*h) + 39*f(x+h) + 56*f(x) - 39*f(x-h) + 12*f(x-2*h) + f(x-3*h))/(6*(h^4));
    end
        
end

