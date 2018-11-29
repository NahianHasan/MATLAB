function I = colorseg(varargin)
    f = varargin{2};
    if ((ndims(f)~=3) | (size(f,3) ~= 3))
        error('The input image must be an RGB Image')
    end
    
    M = size(f,1);
    N = size(f,2);
    
    [f, L] = imstack2vectors(f);
    f = double(f);
    
    I = zeros(M*N,1);
    T = varargin{3};
    m = varargin{4};
    m = m(:)';
    
    if length(varargin) == 4
        method = 'eucliden';
    elseif length(varargin) == 5
        method = 'mahalanobis';
    else
        error('Wrong Number of Inputs');
    end
    
    switch method
        case 'euclidean'
            p = length(f);
            D = sqrt(sum(f-repmat(m,p,1).^2,2));
        case 'mahalanobis'
            C = varargin{5};
            D = mahalanobis(f,C,m);
        otherwise
            error('Unknown Segmentation Method');
    end
    
    J = find(D <= T);
    I(J) = 1;
    I = reshape(I,M,N);
    
end

