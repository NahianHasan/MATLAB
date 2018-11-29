function [xg, yg] = dupgone(x, y)
    % Eliminates duplicate, adjacent rows in [x y], except that the 
    % first and last rows can be equal so that the polygon is closed.

    xg = x;
    yg = y;
    if size(xg, 1) > 2
       I = find((x(1:end-1, :) == x(2:end, :)) & ...
                (y(1:end-1, :) == y(2:end, :)));
       xg(I) = [];
       yg(I) = [];
    end
end