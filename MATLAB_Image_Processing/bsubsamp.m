function [s, su] = bsubsamp(b, gridsep)

    %BSUBSAMP Subsample a boundary.
    % [S, SU] = BSUBSAMP(B, GRIDSEP) subsamples thle boundary B by
    % assigning each of i t s points t o the g r i d nodle t o which it i s
    % closest. The g r i d i s specified by GRIDSEP, which is the
    % separation i n p i x e l s between the g r i d l i n e s . For example, i f
    % GRIDSEP = 2, there are two p i x e l s i n between g r i d l i n e s . So, f o r
    % instance, the g r i d points i n the f i r s t row would be at (1 ,I ),
    % (1,4), (1,6), ..., and s i m i l a r l y i n the y d i r e c t i o n . The value
    % of GRIDSEP must be an even integer. The boundary i s specified by
    % a set of coordinates i n the form of an np-by-2 array. It i s
    % assumed that the boundary i s one p i x e l t h i c k .
    %
    % Output S i s the subsampled boundary. Output SU i s normalized so
    % that the g r i d separation i s u n i t y . This i s useful f o r obtaining
    % the Freeman chain code of the subsampled boundary.
    
    
    % Check i n p u t .
    [np, nc] = size(b);
    if np < nc
        error('B must be of size np-by-2');
    end
    if gridsep/2 ~= round(gridsep/2)
        error('GRIDSEP must be an even integer');
    end
    
    % Some boundary t r a c i n g programs, such as boundaries.m, end with
    % the beginning, r e s u l t i n g i n a sequence i n which the coordinates
    % o f t h e f i r s t and l a s t points are the same. If t h i s i s the case
    % i n b, eliminate the l a s t point.
    if isequal(b(1,:), b(np,:))
        np = np -1;
        b = b(1:np,:);
    end
    
    %find the max x and y spanned by the boundary
    xmax = max(b(:,1));
    ymax = max(b(:,2));
    
    % Determine the number of g r i d l i n e s w i t h gridsep points i n
    % between them that can f i t i n the i n t e r v a l s [l,xmax], [l,ymax],
    % without any points i n b being l e f t over. If points are l e f t
    % over, add zeros t o extend xmax and ymax so that an i n t e g r a l
    % number of g r i d l i n e s are obtained.
    % Size needed i n the x - d i r e c t i o n :

    % Number of g r i d l i n e s i n the x - d i r e c t i o n , with L p i x e l spaces
    % i n between each g r i d l i n e .
    GLx = ceil(xmax + gridsep)/(gridsep + 1);
    
  
    GLy = (ymax + gridsep)/(gridsep + 1);
    
    %Form vectors of x and y grid locations.
    I = 1:GLx;
    %Vector of grid line locations intersecting x-axis.
    X(I) = gridsep*I + (I - gridsep);
    
    J = 1:GLy;
    %Vector of grid line locations intersectinf y-axis
    Y(J) = gridsep*J + (J - gridsep);
    
    % Compute both components of t h e c i t y b l o c k distance between each
    % element of b and a l l the g r i d - l i n e intersections. Assign each
    % point t o the g r i d location f o r which each comp of the c i t y b l o c k
    % distance was less than gridsepi2. Because gridsep i s an even
    % integer, these assignments are unique. Note the use of meshgrid t o
    % optimize the code.
    
    DIST = gridsep / 2;
    [XG, YG] = meshgrid(X,Y);
    Q = 1;
    for k = 1:np
        [I, J] = find(abs(XG - b(k,1)) <= DIST & abs(YG - b(k,2)) <= DIST);
        I = I(1);
        J = J(1);
        ord = k; % To keep track of order of input coordinates
        d1(Q,:) = cat(2,X(I), ord);
        d2(Q,:) = cat(2,Y(J), ord);
        Q = Q + 1;
    end
    
    % d i s the set of points assigned t o the new g r i d with l i n e
    % separation of gridsep. Note that it i s formed as d=(d2,dl) t o
    % compensate for the coordinate transposition inherent i n using
    % meshgrid (see Chapter 2 ) .
    d = cat(2,d1(:,1),d2); % The second column of d1 is ord;
    
    
    % Sort the points using the values i n ord, which i s the l a s t col
    % in d
    d = fliplr(d); % So the last  column becomes first.
    d = sortrows(d);
    d = fliplr(d); % Flip back.
    
    % Eliminate duplicate rows i n the f i r s t two components of
    % d t o create the output. The cw or ccw order MUST be preserved.
    s = d(:,1:2);
    [s, m ,n] = unique(s, 'rows');
    
    % Function unique s o r t s t h e data--Restore t o o r i g i n a l order
    % by using the contents of m.
    s = [s, m];
    s = fliplr(s);
    s = sortrows(s);
    s = fliplr(s);
    s = s(:,1:2);
    
    
    % Scale t o u n i t g r i d so t h a t can use d i r e c t l y t o obtain Freeman
    % chain code. The shape does not change.
    su = round(s./gridsep) + 1;
        
end

