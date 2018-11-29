function [st, angle, x0, y0] = signature(b,varargin)

    %SIGNATURE Computes the signature of a boundary.
    % [ST, ANGLE, XO, YO] = SIGNATURE(B) computes the
    % signature of a given boundary, B, where B i s an np-by-2 array
    % (np > 2) containing the (x, y) coordinates of the boundary
    % ordered i n a clockwise or counterclockwise d i r e c t i o n . The
    % amplitude of the signature as a function of increasing ANGLE i s
    % output i n ST. (X0,YO) are the coordinates of the centroid of the
    % boundary. The maximum size of arrays ST and ANGLE i s 360-by-1,
    % i n d i c a t i n g a maximum resolution of one degree. The input must be
    % a one-pixel-thick boundary obtained, f o r example, by using the
    % function boundaries. By d e f i n i t i o n , a boundary i s a closed curve.
    %
    % [ST, ANGLE, XO, YO] = SIGNATURE(B) computes the signature, using
    % the centroid as the o r i g i n of the signature vector.
    0,
    % [ST, ANGLE, XO, YO] = SIGNATURE(B, XO, YO) computes the boundary
    % using the specified (XO, YO) as the o r i g i n of the signature
    % vector.
    
    
    
    % Check dimensions of b.   
    [np, nc] = size(b);
    if (np < nc | nc ~= 2)
        error('B must be of size np-by-2');
    end
    
    % Some boundary t r a c i n g programs, such as boundaries.m, end where
    % they started, r e s u l t i n g i n a sequence i n which the coordinates
    % of the f i r s t and l a s t points are the same. If t h i s i s the case,
    % i n b, eliminate the l a s t point.
    if isequal(b(1,:), b(np,:))
        b = b(1:np-1, :);
        np = np - 1;
    end
    
    %Compute parameters
    if nargin == 1
        x0 = round(sum(b(:, 1)) / np); %coordinate of the centroid
        y0 = round(sum(b(:, 2)) / np);
    elseif nargin == 3
        x0 = varargin{1};
        y0 = varargin{2};
    else
        error('Incorrect number of inputs');
    end
    
    %Shift the origin of the coordinate system to the position (x0,y0)
    b(:, 1) = b(:, 1) - x0;
    b(:, 2) = b(:, 2) - y0;
    
    % Convert the coordinates t o polar. But f i r s t have t o convert the
    % given image coordinates, (x, y), t o the coordinate system used by
    % MATLAB for conversion betweell Cartesian and polar cordinates.
    % Designate these coordinates by (xc, yc). The two coordinate systems
    % are related as follows: xc = y and yc = -x.
    xc = b(:, 2);
    yc = -b(:, 1);
    [theta, rho] = cart2pol(xc, yc);
    
    %convert angles to degrees
    theta = theta .* (180/pi);
    
    j = theta == 0% store the indices of theta = 0
    
    
    %The code is not complete
    
end

