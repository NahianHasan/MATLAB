function [a0,a1,a2] = second_order_regression(x,y)

    n = length(x);
    sum_x = sum(x(:));
    sum_y = sum(y(:));
    square_x = sum(x(:).*x(:));
    cube_x = sum(x(:).*x(:).*x(:));
    sum_xy = sum(x(:).*y(:));
    sum_x2y = sum(x(:).*x(:).*y(:));
    x_4 = sum(x(:).*x(:).*x(:).*x(:));
    
    
    D = zeros(3,3);
    D(1,1) = n;
    D(1,2) = sum_x;
    D(1,3) = square_x;
    D(2,1) = sum_x;
    D(2,2) = square_x;
    D(2,3) = cube_x;
    D(3,1) = square_x;
    D(3,2) = cube_x;
    D(3,3) = x_4;
    
    C = inv(D);
    Y = [sum_y, sum_xy, sum_x2y]';
   
    P = (C*Y);
   
    a0 = P(1);
    a1 = P(2);
    a2 = P(3);
end

