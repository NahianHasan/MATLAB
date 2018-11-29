function [X,Y] = RK_2(f,a1,a2,p1,q11,h,xi,yi,xf)

    x = xi;
    y = yi;
    X = [x];
    Y = [y];
    
    while(x <= xf)
        k1 = f(x,y);
        k2 = f(x+p1*h,y+q11*k1*h);
        y = y + (a1*k1+a2*k2)*h;
        x = x+h;
        X = [X x];
        Y = [Y y];
    end
end

