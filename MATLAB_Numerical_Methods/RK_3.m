function [X,Y] = RK_3(f,a1,a2,a3,p1,q11,p2,q21,q22,h,xi,yi,xf)

    x = xi;
    y = yi;
    X = [x];
    Y = [y];
    
    while(x <= xf)
        k1 = f(x,y);
        k2 = f(x+p1*h,y+q11*k1*h);
        k3 = f(x+p2*h,y+q21*k1*h+q22*k2*h);
        y = y + (a1*k1+a2*k2+a3*k3)*h;
        x = x+h;
        X = [X x];
        Y = [Y y];
    end
end

