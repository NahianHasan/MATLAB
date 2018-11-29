function [a1, a0] = linear_regression(x,y)

    n = length(x);
    sum_x = sum(x(:));
    sum_y = sum(y(:));
    square_x = sum(x(:).*x(:));
    sum_xy = sum(x(:).*y(:));
    
    a1 = ((n * sum_xy) - (sum_x * sum_y)) / ((n * square_x) - (sum_x*sum_x));
    
    mean_y = sum_y / n;
    mean_x = sum_x / n;
    a0 = mean_y - a1 * mean_x;
    
end

