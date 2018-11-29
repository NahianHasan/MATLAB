function [X,T] = RK_Fehlberg_2nd_order(f,xi,yi,xf,Ti,ea)

    t = Ti;
    x = xi;
    y4 = yi;
    y5 = yi;
    X = [x];
    Y4 = [y4];
    T = [t];
    h = 0.01;
    
    k1 = f(x,y4,t);
    k2 = f(x+0.2*h,y4+0.2*k1*h,t);
    k3 = f(x+0.3*h,y4+0.075*k1*h+0.225*k2*h,t);
    k4 = f(x+0.6*h,y4+0.3*k1*h+0.9*k2*h+1.2*k3*h,t);
    k5 = f(x+h,y4-(11/54)*k1*h+2.5*k2*h-(70/27)*k3*h+(35/27)*k4*h,t);
    k6 = f(x+(7/8)*h,y4+(1631/55296)*k1*h+(175/512)*k2*h+(575/13824)*k3*h+(44275/110592)*k4*h+(253/4096)*k5*h,t);
    y4 = y4 + ((37/378)*k1+(250/621)*k3+(125/594)*k4+(512/1771)*k6)*h;
    y5 = y5 + ((2825/27648)*k1 + (18575/48384)*k3 + (13525/55296)*k4 + (277/14336)*k5 + 0.25*k6);
    x = x+h;    
    
    if(abs(y5-y4) > ea)
        z = 1;
    elseif(abs(y5-y4) <= ea)
        z = 2; 
    end
    
    while(x <= xf)
            if(abs(y5-y4) > ea & z == 2)
                h = h*((abs(abs(y5-y4)/ea))^0.2)
                z = 1;
            elseif(abs(y5-y4) <= ea & z == 1)
                h = h*((abs(abs(y5-y4)/ea)))^0.25
                z = 2;
            end
            k1 = f(x,y4,t);
            k2 = f(x+0.2*h,y4+0.2*k1*h,t);
            k3 = f(x+0.3*h,y4+0.075*k1*h+0.225*k2*h,t);
            k4 = f(x+0.6*h,y4+0.3*k1*h+0.9*k2*h+1.2*k3*h,t);
            k5 = f(x+h,y4-(11/54)*k1*h+2.5*k2*h-(70/27)*k3*h+(35/27)*k4*h,t);
            k6 = f(x+(7/8)*h,y4+(1631/55296)*k1*h+(175/512)*k2*h+(575/13824)*k3*h+(44275/110592)*k4*h+(253/4096)*k5*h,t);
            y4 = y4 + ((37/378)*k1+(250/621)*k3+(125/594)*k4+(512/1771)*k6)*h;
            y5 = y5 + ((2825/27648)*k1 + (18575/48384)*k3 + (13525/55296)*k4 + (277/14336)*k5 + 0.25*k6);
            x = x+h;
            X = [X x];
            Y4 = [Y4 y4];
            t = t + y4*h%Euler's Method
            T = [T t];
        end
end

