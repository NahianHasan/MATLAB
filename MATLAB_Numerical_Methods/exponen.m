function series = exponen()
    % A function for calculating exponential of a specied value(x) upto a
    % certai number of terms(n)
    p = input('Put the value of x and the nth term in the form [x, n]: ');
    x = p(1);
    n = p(2);
    sum = 0;
    for i = 0:1:n-1
        sum = sum + ((x^i) / factorial(i));
    end
    series = sum ;
    sprintf('The value of the exponential function exp(%f) is = %f', x, series)
    
end
