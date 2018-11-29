function sgn = convex_angle_test(xy)
    %   The rows of array xy are ordered vertices of a polygon. If the
    %   kth angle is convex (>0 and <= 180 degress) then sgn(k) =
    %   1. Otherwise sgn(k) = -1. This function assumes that the first
    %   vertex in the list is convex, and that no other vertex has a
    %   smaller value of x-coordinate. These two conditions are true in
    %   the first vertex generated by the MPP algorithm. Also the
    %   vertices are assumed to be ordered in a clockwise sequence, and
    %   there can be no duplicate vertices. 
    %
    %   The test is based on the fact that every convex vertex is on the
    %   positive side of the line passing through the two vertices
    %   immediately following each vertex being considered.  If a vertex
    %   is concave then it lies on the negative side of the line joining
    %   the next two vertices. This property is true also if positive and
    %   negative are interchanged in the preceding two sentences.

    % It is assumed that the polygon is closed.  If not, close it.
    if size(xy, 1) == 1 | ~isequal(xy(1, :), xy(end, :))
       xy(end + 1, :) = xy(1, :);
    end

    % Sign convention: sgn = 1 for convex vertices (i.e, interior angle > 0 
    % and <= 180 degrees), sgn = -1 for concave vertices.

    % Extreme points to be used in the following loop.  A 1 is appended 
    % to perform the inner (dot) product with w, which is 1-by-3 (see 
    % below).
    L = 10^25;
    top_left = [-L, -L, 1];
    top_right = [-L, L, 1];
    bottom_left = [L, -L, 1];
    bottom_right = [L, L, 1];

    sgn = 1; % The first vertex is known to be convex.

    % Start following the vertices. 
    for k = 2:length(xy) - 1
       pfirst= xy(k - 1, :);
       psecond = xy(k, :); % This is the point tested for convexity.
       pthird = xy(k + 1, :);
       % Get the coefficients of the line (polygon edge) passing 
       % through pfirst and psecond. 
       w = polyedge(pfirst, psecond);

       % Establish the positive side of the line w1x + w2y + w3 = 0.
       % The positive side of the line should be in the right side of the
       % vector (psecond - pfirst).  deltax and deltay of this vector
       % give the direction of travel. This establishes which of the
       % extreme points (see above) should be on the + side. If that 
       % point is on the negative side of the line, then w is replaced by -w.

       deltax = psecond(:, 1) - pfirst(:, 1);
       deltay = psecond(:, 2) - pfirst(:, 2);
       if deltax == 0 & deltay == 0
          error('Data into convexity test is 0 or duplicated.')
       end
       if deltax <= 0  & deltay >= 0 % Bottom_right should be on + side.
          vector_product = dot(w, bottom_right); % Inner product.
          w = sign(vector_product)*w;
       elseif deltax <= 0 & deltay <= 0 % Top_right should be on + side.
          vector_product = dot(w, top_right);
          w = sign(vector_product)*w;
       elseif deltax >= 0 & deltay <= 0  % Top_left should be on + side.
          vector_product = dot(w, top_left);
          w = sign(vector_product)*w;
       else % deltax >= 0 & deltay >= 0, so bottom_left should be on + side.
          vector_product = dot(w, bottom_left);
          w = sign(vector_product)*w;
       end
       % For the vertex at psecond to be convex, pthird has to be on the
       % positive side of the line.
       sgn(k) = 1;
       if (w(1)*pthird(:, 1) + w(2)*pthird(:, 2) + w(3)) < 0
          sgn(k) = -1;
       end
    end
end