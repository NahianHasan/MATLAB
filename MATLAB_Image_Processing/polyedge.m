function w = polyedge(p1, p2)
    %   Outputs the coefficients of the line passing through p1 and
    %   p2. The line is of the form w1x + w2y + w3 = 0. 

    x1 = p1(:, 1);  y1 = p1(:, 2);
    x2 = p2(:, 1);  y2 = p2(:, 2);
    if x1==x2
       w2 = 0;
       w1 = -1/x1;
       w3 = 1;
    elseif y1==y2
       w1 = 0;
       w2 = -1/y1;
       w3 = 1;
    elseif x1 == y1 & x2 == y2
       w1 = 1;
       w2 = 1;
       w3 = 0;  
    else
       w1 = (y1 - y2)/(x1*(y2 - y1) - y1*(x2 - x1) + eps);
       w2 = -w1*(x2 - x1)/(y2 - y1);
       w3 = 1;
    end
    w = [w1, w2, w3];
end