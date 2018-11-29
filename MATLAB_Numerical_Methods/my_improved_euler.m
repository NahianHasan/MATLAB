function [X,Y] = my_improved_euler(f,xi,yi,xf,h)

    x = xi;
    y = yi;
    X = [x];
    Y = [y];
    while(x <= xf)
        c = f(x,y);
        p = y + c*h;
        x = x+ h;
        y = y + (h/2)*(c + f(x,p));
        X = [X x];
        Y = [Y y];
    end

end

