function z = connectpoly(x,y)

    %CONNECTPOLY Connects vertices of a polygon.
    % C = CONNECTPOLY(X, Y) connects t h e p o i n t s with coordinates given
    % i n X and Y with s t r a i g h t l i n e s . These points are assumed t o be a
    % sequence of polygon vertices organized i n the clockwise or
    % counterclockwise d i r e c t i o n . The output, C, i s the set of points
    % along the boundary of the polygon i n the form of an nr-by-2
    % coordinate sequence i n the same d i r e c t i o n as the input. The l a s t
    % point i n the sequence i s equal t o the f i r s t .
    v = [x(:), y(:)];
    
    %close polygon
    if ~isequal(v(end,:), v(1,:))
        v(end+1,:) = v(1,:);
    end
    
    %connect vertices
    segments = cell(1,length(v) - 1);
    for I = 2:length(v)
        [x, y] = intline(v(I-1, 1), v(I,1), v(I-1,2), v(I,2));
        segments{I-1} = [x, y];
    end
    
    z = cat(1, segments{:});
  
end

