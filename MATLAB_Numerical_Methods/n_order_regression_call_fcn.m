function [] = n_order_regression_call_fcn(k)
    x = [0,1,2,3,4,5];
    y = [2.1,7.7,13.6,27.2,40.9,61.1];

    P = n_order_regression(x,y,k);
    M = length(P)-1;
    Y = [];
    for i = 1:0.1:20
        c = P(1);
        for j = 1:M
            c = c + P(1+j) * power(i,j);
        end
        Y = [Y c];
    end

    s = 1:0.1:20;
    plot(s,Y,x,y,'*');
    legend('regression Line', 'Data Points');
    
end

