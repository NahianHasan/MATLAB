function [X,Y] = RK_5_butcher(f,a1,a2,a3,a4,a5,a6,p1,q11,p2,q21,q22,p3,q31,q32,q33,p4,...
    q41,q42,q43,q44,p5,q51,q52,q53,q54,q55,h,xi,yi,xf)

    x = xi;
    y = yi;
    X = [x];
    Y = [y];
    
    while(x <= xf)
        k1 = f(x,y);
        k2 = f(x+p1*h,y+q11*k1*h);
        k3 = f(x+p2*h,y+q21*k1*h+q22*k2*h);
        k4 = f(x+p3*h,y+q31*k1*h+q32*k2*h+q33*k3*h);
        k5 = f(x+p4*h,y+q41*k1*h+q42*k2*h+q43*k3*h+q44*k4*h);
        k6 = f(x+p5*h,y+q51*k1*h+q52*k2*h+q53*k3*h+q54*k4*h+q55*k5*h);
        y = y + (a1*k1+a2*k2+a3*k3+a4*k4+a5*k5+a6*k6)*h;
        x = x+h;
        X = [X x];
        Y = [Y y];
    end
end

