function b8 = bound2eight(f)
    %BOUND2EIGHT Convert 4-connected boundary to 8-connected boundary.
% RC-NEW = BOUNDZEIGHT(RC) converts a four-connected boundary t o an
% eight-connected boundary. RC i s a P-by-2 matrix, each row of
% which contains the row and column coordinates of a boundary
% p i x e l . RC must be a closed boundary; i n other words, the l a s t
% row of RC must equal the f i r s t row of RC. BOUND2EIGHT removes
% boundary p i x e l s t h a t are necessary f o r four-connectedness but not
% necessary f o r eight-connectedness. RC-NEW i s a Q-by-2 matrix,
% where Q <= P.

    if ~isempty(f) & ~isequal(f(1,:), f(end, :))
        error('Expected input boundary to be closed');
    end
    
    if size(f,1) <= 3
        %degenerate case
        b8 = f;
        return;
    end
    
    %rremove last row which equals the first row
    b8 = f(1:end-1,:);
    
    % Remove the mlddle plxel In four-connected rlght-angle turns. We
    % can do thls In a vectorlzed fashlon, but we can't do lt a l l at
    % once. Slmllar t o the way the 'thln' algorithm works ln bwmorph,
    % w e ' l l remove flrst the mlddle plxels In four-connected turns where
    % the row and column are both even; then the mlddle plxels In a l l
    % the remaining four-connected turns where the row 1s even and the
    % column 1s odd; then agaln where the row 1s odd and the column 1s
    % even; and flnally where both the row and column are odd.
    
    remove_locations = compute_remove_locations(b8);
    field1 = remove_locations & (rem(b8(:,1),2) == 0) & (rem(b8(:,2),2) == 0);
    b8(field1,:) = [];
    
    remove_locations = compute_remove_locations(b8);
    field2 = remove_locations & (rem(b8(:,1),2) == 0) & (rem(b8(:,2),2) == 1);
    b8(field2,:) = [];
    
    remove_locations = compute_remove_locations(b8);
    field3 = remove_locations & (rem(b8(:,1),2) == 1) & (rem(b8(:,2),2) == 0);
    b8(field3,:) = [];

    remove_location = compute_remove_locations(b8);
    field1 = remove_locations & (rem(b8(:,1),2) == 1) & (rem(b8(:,2),2) == 1);
    b8(field4,:) = [];

    %make the output boundary closed again
    b8 = [b8; b8(1,:)];

end

