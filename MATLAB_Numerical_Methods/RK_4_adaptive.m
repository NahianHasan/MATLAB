function [X,Y] = RK_4_adaptive(f,a1,a2,a3,a4,p1,q11,p2,q21,q22,p3,q31,q32,q33,xi,yi,xf,emax)

    x = xi;
    y = yi;
    X = [x];
    Y = [y];
    h = xf-x;
    ea = 100;
    
    while(ea > emax)
        h = h/5;
        m = y;
        while(x <= xf)
            k1 = f(x,y);
            k2 = f(x+p1*h,y+q11*k1*h);
            k3 = f(x+p2*h,y+q21*k1*h+q22*k2*h);
            k4 = f(x+p3*h,y+q31*k1*h+q32*k2*h+q33*k3*h);
            y = y + (a1*k1+a2*k2+a3*k3+a4*k4)*h;
            x = x+h;
            X = [X x];
            Y = [Y y];       
        end
        ea = abs((y - m)/y);
    end
end

