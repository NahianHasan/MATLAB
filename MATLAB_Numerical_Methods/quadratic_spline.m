function B = quadratic_spline(x,y)

    n1 = length(x);%number of datapoints
    n = n1 - 1;%there are 3*n unknown coefficients to be determined
    
    M = zeros(3*n,3*n);
    j = 1;%The index for column adjustment in each new row calculation
    Y = zeros(3*n,1);
    i = 1;%index for calculating the number of equations
    k = 1;%index for keeping track of row index
    m = 2;%index for keeping track of x's value
    p = (2*n - 2) / 2;%necessary steps for total calculation of (2*n-2) equations

    %%
    %Equation determination according to the first condition of quadratic
    %spline that "The function values of adjacent polynomials must be equal
    %at the interior knots."
    while (i <= p+1)
        if i==1
            M(k,j:j+2) = [x(m)*x(m), x(m), 1];
            j = j+3;
            Y(k,1) = y(i+1);
            i = i+1;
            k = k+1;
        elseif (i>1 && i < p+1)
            M(k,j:j+2) = [x(m)*x(m), x(m), 1];
            Y(k,1) = y(i);
            k = k+1;
            m = m+1;
            M(k,j:j+2) = [x(m)*x(m), x(m), 1];
            j = j+3;
            Y(k,1) = y(i+1);
            i = i+1;
            k = k+1;
        elseif i == p+1
            M(k,j:j+2) = [x(end-1)*x(end-1), x(end-1), 1];
            Y(k,1) = y(end-1);
            i = i+1;
            k = k+1;
            
        end
    end
    %%
    %Equation determination according to the 2nd condition of quadratic
    %spline that "The first and last functions must pass through the end points."
    j = 2*n-2;
    M(j+1,1:3) = [x(1)*x(1), x(1), 1];
    Y(j+1,1) = y(1);
    M(j+2,3*n-2:3*n) = [x(end)*x(end), x(end), 1];
    Y(j+2,1) = y(end);
    
    %%
    %Equation determination according to the 3rd condition of quadratic
    %spline that "The first derivatives at the interior knots must be equal."
    k = j+3;
    j = 1;
    for i = 1:n-1
        M(k,j:j+5) = [2*x(i+1), 1, 0, -2*x(i+1), -1, 0];
        k = k+1;
        j = j+3;
    end
    %%
    %%Equation determination according to the 3rd condition of quadratic
    %spline that "Assume that the second derivative is zero at the first point."
    %So, there would be in total 3*n-1 equations and 3*n-1 unknown
    %coefficients to be determined.so deduct the first column of M (for a1 is no more there) 
    %and last row of M(as one less equation is needed now)
    M = M(1:end-1,2:end);
    Y = Y(1:end-1,1);
    
    %%
    %Solving the system of linear equations Mb = Y
    X = [M Y];
    B = Gauss_Jordan(X);
    B = [0 B];
    c = length(B) / 3;
    B = reshape(B,3,c);%B is a matrix each column of which contain the 3 coefficients of each spline segment
end

