function [h, theta, rho] = houghman(f, dtheta, drho)
    if nargin < 3
        drho = 1;
    end
    if nargin < 2;
        dtheta = 1;
    end
    
    f = double(f);
    [M,N] = size(f);
    theta = linspace(-90,0,ceil(90/dtheta)+1);
    theta = [theta -fliplr(theta(1:end-1))];%-90<= theta <= 90
    ntheta = length(theta);
    
    
    D = sqrt((M-1)^2 + (N-1)^2);
    q = ceil(D/drho);%number of segments along the rho positive axis
    nrho = 2*q - 1;%total number of rho seegments both along positive and negative axis
    rho = linspace(-q*drho,q*drho,nrho);%-D<= rho <=D
    
    
    [x, y, val] = find(f);
    x = x-1;%as in MATLAB initial position is counted from 1, not from zero.
    y = y-1;
    
    h = zeros(nrho,ntheta);%initializing hughman matrix to zero
    
    for k = 1:ceil(length(val)/1000)
        first = (k-1)*1000 + 1;
        last = min(first+999, length(x));
        
        x_matrix = repmat(x(first:last), 1, ntheta);%repmat is used as we are working by taking 1000 points at a time
        y_matrix = repmat(y(first:last), 1, ntheta);
        val_matrix = repmat(val(first:last), 1, ntheta);
        
        theta_matrix = repmat(theta, size(x_matrix,1),1)*pi/180;
        rho_matrix = x_matrix.*cos(theta_matrix) + y_matrix.*sin(theta_matrix);
        
        slope = (nrho-1)/(rho(end) - rho(1));
        rho_bin_index = round(slope*(rho_matrix - rho(1)) + 1);
        theta_bin_index = repmat(1:ntheta, size(x_matrix,1), 1);
        
        h = h + full(sparse(rho_bin_index(:), theta_bin_index(:), val_matrix(:), nrho, ntheta));
    end
end

