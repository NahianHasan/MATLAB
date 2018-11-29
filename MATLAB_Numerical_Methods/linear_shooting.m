function Q = linear_shooting(f,h,xi,yi,xf,Ti,Tf,ea)

    y = yi;
    [X,T] = RK_Fehlberg_2nd_order(f,xi,yi,xf,Ti,ea);
    m = T(xf);
    P = m;
    i = 1;
    j = 1;
    if(m < Tf)
        while(m < Tf)
            i = i + 1
            X = [];
            Y = [];
            yi = yi+10;
            [X,T] = RK_Fehlberg_2nd_order(f,xi,yi,xf,Ti,ea);
            m = T(xf);
        end
        Q = P + ((y - yi)/(m - P)) * (Tf - P);
    else
        while(m > Tf)
            j = j+1
            X = [];
            Y = [];
            yi = yi-10;
            [X,T] = RK_Fehlberg_2nd_order(f,xi,yi,xf,Ti,ea);
            m = T(xf);
        end
        Q = m + ((y - yi)/(P - m)) * (Tf - m);
    end
end

