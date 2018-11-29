function [x,y ] = minperpoly(B,cellsize)

    %MINPERPOLY Computes the minimum perimeter polygon.
    % [X, Y] = MINPERPOLY(F, CELLSIZE) computes the vertices i n [X, Y]
    % of the minimum perimeter polygon of a single binary region or
    % boundary i n image 0. The procedure i s based on Slansky's
    % shrinking rubber band approach. Parameter CELLSIZE determines the
    % size of the square c e l l s t h a t enclose the boundary of the region
    % i n 8. CELLSIZE must be a nonzero integer greater than 1.
    %
    % The algorithm i s applicable only t o boundaries that are not
    % s e l f - i n t e r s e c t i n g and that do not have one-pixel-thick
    % protrusions.

    if cellsize <= 1
        error('cellsize must be an integer greater than 1');
    end
    
    % F i l l B i n case the input was provided as a boundary. Later
    % the boundary w i l l be extracted with 4-connectivity, which
    % i s required by the algorithm. The use of bwperim assures
    % that 4-connectivity i s preserved a t t h i s point.
    B = imfill(B, 'holes');
    B = bwperim(B);
    [M, N] = size(B);
    
    % Increase image size so t h a t the image i s of size K-by-K
    % with (a) K >= max(M,N) and (b) K/cellsize = a power of 2.
    K = nextpow2(max(M,N)/ cellsize);
    K = (2^K) * cellsize;
    
    % Increase image size t o nearest integer power of 2, by
    % appending zeros t o the end of the image. This w i l l allow
    % quadtree decompositions as small as c e l l s of size 2-by-2,
    % which i s the smallest allowed value o f c e l l s i z e .
    
    M = K - M;
    N = K - N;
    B = padarray(B, [M N], 'post');%image is now of size K-by-K
    
    %quadtree decomposition
    Q = qtdecomp(B,0,cellsize);
    
    %get all the subimages
    [vals, r, c] = qtgetblk(B, Q, cellsize);
    
    % Get a l l the subimages that contain at least one black
    % p i x e l . These are the c e l l s of the w a l l enclosing the boundary.
    I = find(sum(sum(vals(:,:,:)) >= 1));
    x = r(I);
    y = c(I);
    
    % [x', y ' ] i s a length(1)-by-2 array. Each member of t h i s array i s
    % the l e f t , top corner of a black c e l l of size c e l l s i z e - b y - c e l l s i z e .
    % F i l l the c e l l s with black t o form a closed border of black c e l l s
    % around i n t e r i o r points. These! c e l l s are the c e l l u l a r complex.
    for k = 1:length(I)
        B(x(k):x(k) + cellsize-1, y(k):y(k) + cellsize - 1) = 1;
    end
    BF = imfill(B,'holes');
    B = BF & (~B);
    
    % Extract the 4-connected boundary.
    B = boundaries(B,4,'cw');
    
    % Find the largest one i n case of p a r a s i t i c regions.
    J = cellfun('length', B);
    I = find(J == max(J));
    B = B{I(1)};
    
    % Function boundaries outputs the l a s t coordinate p a i r equal t o the
    % f i r s t . Delete it.
    B = B(1:end-1,:);
    
    % Obtain the xy coordinates of the boundary.
    x = B(:,1);
    y = B(:,2);
    
    % Find the smallest x-coordinate and corresponding
    % smallest y -coordinate.
    cx = find(x == min(x));
    cy = find(y == min(y(cx)));
    
    % The c e l l with top leftmost corner at ( x l , yl) below i s the f i r s t
    % point considered by the algorithm. The remaining points are
    % v i s i t e d i n the clockwise direcition s t a r t i n g at (xl, yl).
    x1 = x(cx(1));
    y1 = y(cy(1));
    
    
    % S c r o l l data so t h a t t h e f i r s t point i s (xi, y l ) .
    I = find(x == x1& y == y1);
    x = circshift(x, [-(I - 1), 0]);
    y = circshift(y, [-(I - 1), 0]);
    B = circshift(B, [-(I - 1), 0]);
    
    % Get the Freeman chain code.
    code = fchcode(B,4, 'same');
    code = code.fcc;
    
    % Follow the code sequence t o e x t r a c t the Black Dots, BD, (convex
    % corners) and White Dots, WD, (concave corners). The t r a n s i t i o n s are
    % as follows: 0-to-l=WD; 0-to-3=BD; I-to-O=BD; I-to-2=WD; 2-to-l=BD;
    % 2-to-3=WD; 3-to-O=WD; 3-to-2=dot. The formula t = 2*first - second
    % gives t h e f o l l o w i n g unique values f o r these t r a n s i t i o n s : -1, -3, 2,
    % 0, 3, 1, 6, 4. These are applicable t o t r a v e l i n the cw d i r e c t i o n .
    % The WD's are displaced one-half a diagonal from the 8D's t o form
    % the h a l f - c e l l expansion required i n the algorithm.
    % Vertices w i l l be computed as array " v e r t i c e s " o f dimension nv-by-3,
    % where nv i s the number of vertices. The f i r s t two elements of any
    % row of array vertices are the (x,y) coordinates of the vertex
    % corresponding t o t h a t row, and the t h i r d element i s 1 i f the
    % vertex i s convex (BD) o r 2 i f it i s concave (WD). The f i r s t vertex
    % i s known t o be convex, so it i s black.
    vertices = [x1, y1, 1];
    n = 1;
    k = 1;
    
    for k = 2:length(code)
        if code(k-1) ~= code(k)
            n = n + 1;
            t = 2 * code(k-1) - code(k);
            if t == -3 | t == 2 | t == 3 | t == 4
                vertices(n, 1:3) = [x(k), y(k), 1];%Black dots
            elseif t == -1 | t == 0 | t == 1 | t == 6% white dots
                if t == -1
                    vertices(n,1:3) = [x(k) - cellsize, y(k) - cellsize, 2];
                elseif t == 0
                    vertices(n,1:3) = [x(k) + cellsize, y(k) - cellsize, 2];
                elseif t == 1
                    vertices(n,1:3) = [x(k) + cellsize, y(k) + cellsize, 2];
                else
                    vertices(n,1:3) = [x(k) - cellsize, y(k) + cellsize, 2];
                end
            end
        end
    end
    
    % The rest of minperpo1y.m processes the vertices t o
    % a r r i v e at the MPP.
    flag = 1;
    while flag
        % Determine which vertices l i e on or i n s i d e t h e
        % polygon whose vertices are the Black Dots. Delete a l l
        % other points.
        I = find(vertices(:,3) == 1);
        xv = vertices(I,1);% coordinates of black dots
        yv = vertices(I,2);
        X = vertices(:,1);% coordinates of all vertices
        Y = vertices(:,2);
        IN = inpolygon(X,Y,xv,yv);
        I = find(IN ~= 0);
        vertices = vertices(I,:);
        
        % Now check f o r any Black Dots that may have been turned i n t o
        % concave vertices a f t e r the previous deletion step. Delete
        % any such Black Dots and recompute the polygon as i n the
        % previous section of code. When no more changes occur, set
        % f l a g t o 0, which causes the loop t o terminate.
        x = vertices(:,1);
        y = vertices(:,2);
        angles = polyangles(x,y);%find all the internal angles
        I = find(angles > 180 & vertices(:,1) == 1);
        if isempty(I)
            flag = 0;
        else
            J = 1:length(vertices)
            for k = 1:length(I)
                K = find(J ~= I(k));
                J = J(K);
            end
            vertices = vertices(J,:);
        end
    end
    
    % F i n a l pass t o delete the vertices with angles of 180 degrees.
    x = vertices(:,1);
    y = vertices(:,2);
    angles = polyangles(x,y);
    I = find(angles ~= 180);
    %vertices of MPP
    x = vertices(I,1);
    y = vertices(I,2);
     
end

