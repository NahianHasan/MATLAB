function [X,Y,T] = second_order_diff(f,xi,yi,ti,tf,h)

    x = xi;
    y = yi;
    t = ti;
    X = [x];
    Y = [y];
    T = [t];
    while(t <= tf)
        c = f(x,y);
        p = y + c*h;
        t = t+ h;
        y = y + (h/2)*(c + f(x,p));
        x = x + y*h;
        T = [T t];
        X = [X x];
        Y = [Y y];
    end

end

