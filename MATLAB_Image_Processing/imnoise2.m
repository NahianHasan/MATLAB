function R = imnoise2(type,M, N, a, b)
    if nargin == 1
        a = 0;
        b = 1;
        M = 1;
        N = 1;
    elseif nargin == 3
        a = 0;
        b = 1;
    end
    switch lower(type)
        case 'uniform'
            R = a + (b - a)* rand(M,N);
        case 'gaussian'
            R = a + b*randn(M,N);%see the randn() function.
        case 'salt & pepper'
            if nargin <= 3
                a = 0.05;
                b = 0.05;
            end
            if(a + b) > 1
                error('the sum pa+pb must not exceed 1')
            end
            R(1:m, 1:N) = 0.05;
            X = rand(M,N);
            c = find(X <= a);
            R(c) = 0;
            u = a+b;
            c = find(X > a & X <= u);
            R(c) = 1;
        case 'lognormal'
            if nargin <= 3
                a = 1;
                b = 0.25;
            end
            R = a*exp(b*randn(M,N));
        case 'rayleigh'
            R = a + sqrt(-b*log(1 - rand(M,N)))
        case 'exponential'
            if nargin <= 3
                a = 1;
            end
            if a <= 0
                error('Parameter "a" must be positive for the exponential case');
            end
            k = -1/a;
            R = k*log(1 - rand(M,N));
        case 'erlang'
            if nargin <= 3
                a = 2;
                b = 5;
            end
            if(b~= round(b) | b <= 0)
                error('Parmeter b must be positive for the erlang');
            end
            k = -1/a;
            R = zeros(M,N);
            for j = 1:b
                R = R + k*log(1 - rand(M,N));
            end
        otherwise
            error('Unknown distribution type');
    end           
end

