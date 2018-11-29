function angles = polyangles(x, y)
    %POLYANGLES Computes internal polygon angles.
    %   ANGLES = POLYANGLES(X, Y) computes the interior angles (in
    %   degrees) of an arbitrary polygon whose vertices are given in 
    %   [X, Y], ordered in a clockwise manner.  The program eliminates
    %   duplicate adjacent rows in [X Y], except that the first row may
    %   equal the last, so that the polygon is closed.  

    %   Copyright 2002-2004 R. C. Gonzalez, R. E. Woods, & S. L. Eddins
    %   Digital Image Processing Using MATLAB, Prentice-Hall, 2004
    %   $Revision: 1.6 $  $Date: 2003/11/21 14:44:06 $

    % Preliminaries.
    [x y] = dupgone(x, y); % Eliminate duplicate vertices.
    xy = [x(:) y(:)];
    if isempty(xy)
       % No vertices!
       angles = zeros(0, 1);
       return;
    end
    if size(xy, 1) == 1 | ~isequal(xy(1, :), xy(end, :))
       % Close the polygon
       xy(end + 1, :) = xy(1, :);
    end

    % Precompute some quantities.
    d = diff(xy, 1);
    v1 = -d(1:end, :);
    v2 = [d(2:end, :); d(1, :)];
    v1_dot_v2 = sum(v1 .* v2, 2);
    mag_v1 = sqrt(sum(v1.^2, 2));
    mag_v2 = sqrt(sum(v2.^2, 2));

    % Protect against nearly duplicate vertices; output angle will be 90
    % degrees for such cases. The "real" further protects against
    % possible small imaginary angle components in those cases.
    mag_v1(~mag_v1) = eps;
    mag_v2(~mag_v2) = eps;
    angles = real(acos(v1_dot_v2 ./ mag_v1 ./ mag_v2) * 180 / pi);

    % The first angle computed was for the second vertex, and the
    % last was for the first vertex. Scroll one position down to 
    % make the last vertex be the first.
    angles = circshift(angles, [1, 0]);

    % Now determine if any vertices are concave and adjust the angles
    % accordingly.
    sgn = convex_angle_test(xy);

    % Any element of sgn that's -1 indicates that the angle is
    % concave. The corresponding angles have to be subtracted 
    % from 360.
    I = find(sgn == -1);
    angles(I) = 360 - angles(I);

end