function m = linear_spline(x,y)
    %m = vector of slope of each spline segment
    n = length(x);
    m = [];
    for i = 1:n-1
        c = (y(i+1) - y(i)) / (x(i+1) - x(i));
        m = [m c];
    end
        
end

