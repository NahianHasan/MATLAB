function [a,b1] = linear_regression_using_log(x,y)
    %A function for building a linear regression model of the equation
    %       y = b1 * x^a
    %The function has been modified using log such as
    %   log(y) = log(b1) + a*log(x)

    n = length(x);
    x = log10(x(:));
    y = log10(y(:));
    
    sum_x = sum(x(:));
    sum_y = sum(y(:));
    square_x = sum(x(:).*x(:));
    sum_xy = sum(x(:).*y(:));
    
    a = ((n * sum_xy) - (sum_x * sum_y)) / ((n * square_x) - (sum_x*sum_x));%a is slope
    
    mean_y = sum_y / n;
    mean_x = sum_x / n;
    b = mean_y - a * mean_x;%b = intercept
    b1 = power(10,b);
    
end

