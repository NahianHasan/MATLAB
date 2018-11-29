function B = boundaries(f,conn,dir)

    % B = BOUNDARIES(f) traces the extrior boundaries of objects in
    % the binary image f. B is a P-by-1 cell array, where P is the
    % number of objects in the image. Each cell contains a Q-by-2
    % matrix, each row of which contains the row and column coordinates
    % of a boundary pixel . Q  is the number of boundary pixels for the
    % corresponding object. Object boundaries are traced i n the
    % clockwise direction .
    % B = BOUNDARIES(f, CONN) specifies the connectivity to use when
    % tracing boundaries. CONN may be either 8 or 4. The default
    % value for CONN is 8.
    % B = BOUNDARIES(f, CONN, DIR) specifies the direction used for
    % tracing boundaries. DIR should be either 'cw' (trace boundaries
    % clockwise) or 'ccw' (trace boundaries counterclockwise). If DIR
    % is omitted BOUNDARIES traces in the clockwise direction .
    
    
    if nargin < 3
        dir = 'cw';
    end
    
    if nargin < 2
        conn = 8;
    end
    
    L = bwlabel(f,conn);
    
    % The number of objects i s the maximum value of L. I n i t i a l i z e the
    % c e l l array B so that each c e l l i n i t i a l l y contains a 0-by-2 matrix.
    numobjects = max(L(:));
    if numobjects > 0
        B = {zeros(0,2)};
        B = repmat(B,numobjects,1);
    else
        B = {};
    end
    
    % Pad l a b e l matrix with zeros. This l e t s us w r i t e the
    % boundary-following loop without worrying about going o f f the edge
    % of the image.
    Lp = padarray(L, [1 1], 0, 'both');
    
    % Compute the l i n e a r indexing o f f s e t s t o take us from a p i x e l t o i t s
    % neighbors.
    M = size(Lp,1);
    
    if conn == 8
        % Order i s N NE E SE S SW W NW.
        offsets = [-1, M-1, M, M+1, 1, -M+1, -M, -M-1];
    else
        % Order i s N E S W.
        offsets = [-1, M, 1, -M];
    end
    
    % next-search-direction-lut i s a lookup table. Given t h e d i r e c t i o n
    % from p i x e l k t o p i x e l k+l, what i s the d i r e c t i o n t o s t a r t with when
    % examining the neighborhood of p i x e l k+l?
    if conn == 8
        next_search_direction_lut = [8 8 2 2 4 4 6 6];
    else
        next_search_direction_lut = [4, 1, 2, 3];
    end
    
    % next-direction-lut i s a lookup table. Given that we just looked a t
    % neighbor i n a given d i r e c t i o n , which neighbor do we look a t next?
    if conn == 8
        next_direction_lut = [2, 3, 4, 5, 6, 7, 8, 1];
    else
        next_direction_lut = [2, 3, 4, 1];
    end
    
    % Values used f o r marking the s t a r t i n g and boundary p i x e l s .
    START = -1;
    BOUNDARY = -2;
    
    % I n i t i a l i z e scratch space i n which t o record the boundary p i x e l s as
    % w e l l as f o l l o w the boundary.
    scratch = zeros(100,1);
    
    % Find candidate s t a r t i n g locations f o r boundaries.
    [rr,cc] = find((Lp(2:end-1,:) > 0) & (Lp(1:end-2, :) == 0));
    rr = rr + 1;
    
    for k = 1:length(rr)
        r = rr(k);
        c = cc(k);
        if(Lp(r,c) > 0) & (Lp(r-1, c) == 0) & isempty(B{Lp(r,c)})
           % We've found the s t a r t of the next boundary. Compute i t s
            % l i n e a r o f f s e t , record which boundary it i s , mark it, and
            % i n i t i a l i z e the counter f o r the number of boundary p i x e l s .
            idx = (c-1)*size(Lp,1) + r;
            which = Lp(idx);
            scratch(1) = idx;
            Lp(idx) = START;
            numPixels = 1;
            currentPixel = idx;
            initial_departure_direction = [];
            done = 0;
            
            next_search_direction = 2;
            while ~done
                % Find the next boundary p i x e l .
                direction = next_search_direction;
                found_next_pixel = 0;
                for k = 1:length(offsets)
                    neighbour = currentPixel + offsets(direction);
                    if(Lp(neighbour) ~= 0)
                        % Found the next boundary p i x e l .
                        if(Lp(currentPixel) == START) & isempty(initial_departure_direction)
                           % We are making the i n i t i a l departure from
                            % the startinlg p i x e l .
                            initial_departure_direction = direction;
                        elseif(Lp(currentPixel) == START) & (initial_departure_direction == direction)
                            % We are about t o retrace our path.
                            % That means we're done.
                            done = 1;
                            found_next_pixel = 1;
                            break;
                        end
                        
                        % Take the next step along the boundary.
                        next_search_direction = next_search_direction_lut(direction);
                        found_next_pixel = 1;
                        numPixels = numPixels + 1;
                        if numPixels > size(scratch, 1)
                            % Double the scratch space.
                            scratch(2*size(scratch,1)) = 0;
                        end
                        scratch(numPixels) = neighbour;
                        
                        if Lp(neighbour) ~= START
                            Lp(neighbour) = BOUNDARY;
                        end
                        
                        currentPixel = neighbour;
                        break;
                    end
                    direction = next_direction_lut(direction);
                end
                
                if ~found_next_pixel
                    % If there i s no next neighbor, the object must j u s t
                    % have a single p i x e l .
                    numPixels = 2;
                    scratch(2) = scratch(1);
                    done = 1;
                end
            end
          
            % Convert l i n e a r indices t o row-column coordinates and save
            % i n the output c e l l array.
            [row, col] = ind2sub(size(Lp), scratch(1:numPixels));
            B{which} = [row-1, col - 1];
        end
    end
    
    if strcmp(dir, 'ccw')
        for k = 1:length(B)
            B{k} = B{k}(end:-1:1,:);
        end
    end
end

