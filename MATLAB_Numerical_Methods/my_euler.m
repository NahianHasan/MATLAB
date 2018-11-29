function [X,Y] = my_euler(f,xi,yi,xf,h)

    x = xi;
    y = yi;
    X = [x];
    Y = [y];
    while(x <= xf)
        y = y + f(x,y)*h;
        X = [X x];
        Y = [Y y];
        x = x+ h;
    end

end

