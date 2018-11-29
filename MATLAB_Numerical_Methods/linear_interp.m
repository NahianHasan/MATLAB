function [] = linear_interp(x,y)

    n = length(x);
    Y = [];
    for i = 1:n-1
        for j = x(i):0.1:x(i+1)
            f1 = ((j - x(i+1))/(x(i) - x(i+1))*y(i));
            f2 = ((j - x(i))/(x(i) - x(i+1)))*y(i+1);
            f = f1-f2;
            if(i ~= 1 & j == x(i))
                continue;
            end
            Y = [Y f];
        end
    end
    
    s = x(1):0.1:x(n);
    plot(s,Y);
    grid on
    axis tight;        
end

