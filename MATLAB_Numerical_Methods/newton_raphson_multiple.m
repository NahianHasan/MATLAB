function root = newton_raphson_multiple(f,x,tol)
    
    s = -10:0.1:10;
    y = f(s);
    plot(s,y);
    hold on
    
    root = x - ((f(x)*forward_difference(f,x,0.001,1,2))/((forward_difference(f,x,0.001,1,2))^2 - f(x)*forward_difference(f,x,0.001,2,2)));
    X = [x root];
    Y = [f(x) 0];
    plot(X,Y)
    
    iter = 1;
    for i = 1:1000
        if(abs(root) > tol)
        x = root;
        iter =iter +1;
        root = x - ((f(x)*forward_difference(f,x,0.001,1,2))/((forward_difference(f,x,0.001,1,2))^2 - f(x)*forward_difference(f,x,0.001,2,2)));
        X = [x root];
        Y = [f(x) 0];
        plot(X,Y)
        end
    end
end

