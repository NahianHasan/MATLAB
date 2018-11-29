function b4 = bound2four(f)

    %BOUND2FOUR Convert 8-connected boundary to 4-connected boundary.
    % RC-NEW = BOUND2FOUR(RC) converts an elght-connected boundary t o a 
    % four-connected boundary. RC 1s a P-by-2 matrlx, each row of 
    % which contains the row and column coordinates of a boundary 
    % plxel. BOUND2FOUR lnserts new boundary p i x e l s wherever there 1s 
    % a diagonal connection.

    if size(f,1) > 1
        % Phase 1: remove dlagonal turns, one a t a tlme untll they are a l l gone.
        done = 0;
        f1 = [f(end-1,:);f];
        while ~done
            d = diff(f1,1);
            diagonal_locations = all(d,2);
            double_diagonals = diagonal_locations(1:end-1) & (diff(diagonal_locations,1) == 0);
            double_diagonal_idx = find(double_diagonals);
            turns = any(d(double_diagonal_idx,:) ~= d(double_diagonal_idx+1,:), 2);
            turn_idx = double_diagonal_idx(turns);
            if isempty(turns_idx)
                done = 1;
            else
                first_turn = turns_idx(1);
                f1(first_turn+1,:) = (f1(first_turn, :) + f1(first_turn+1,:)) / 2;
                
                if first_turn == 1
                    f1(end,:) = f1(2,:);
                end
            end
        end
        
        f1 = f1(2:end,:);
    end
    
    % Phase 2: i n s e r t extra p i x e l s where there are diagonal connections.
    rowdiff = diff(f1(:,1));
    coldiff = diff(f1(:,2));
    
    diagonal_locations = rowdiff & coldiff;
    num_old_pixels = size(f1,1);
    num_new_pixels = num_old_pixels + sum(diagonal_locations);
    b4 = zeros(num_new_pixels,2);
    % I n s e r t the o r i g i n a l values i n t o the proper locatlons i n the new RC
    % matrix.
    idx = (1:num_old_pixels)' + [0;cumsum(diagonal_locations)];
    b4(idx,:) = f1;
    
    %compute the new pixels to be inserted
    new_pixel_offsets = [0 1; -1 0; 1 0; 0 -1];
    offset_codes = 2 * (1 - (coldiff(diagonal_locations) + 1)/2) + (2 - (rowdiff(diagonal_locations) + 1) /2);
    new_pixels = f1(diagonal_locations,:) + new_pixel_offsets(offset_codes,:);
    
    %where do the new pixels go?
    insertion_locations = zeros(num_new_pixels,1);
    insertion_locations(idx) = 1;
    insertion_locations = ~insertion_locations;
    
    %Insert the new pixels
    b4(insertion_locations,:) = new_pixels;  
    
end

