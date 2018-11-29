function [xe,xo,m] = even_odd(x1,n1)

    [x2,n2] = sigfold(x1,n1);
    xe = 0.5 * sigadd(x1,n1,x2,n2);
    xo = 0.5 * sigadd(x1,n1,-x2,n2);
    
    m = min(min(n1),min(n2)):max(max(n1),max(n2));
    
end