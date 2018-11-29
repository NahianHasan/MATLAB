function remove = compute_remove_locations(f)

    %circular diff
    d = [f(2:end,:); d(1,:)] - f;
    
    % Dot product of each row of d with the subsequent row of d,
    % performed i n c i r c u l a r fashion.
    d1 = [d(2:end,:); d(1,:)];
    dotprod = sum(d .* d1,2);
    
    % Locations of N, S, E, and W t r a n s i t i o n s followed by
    % a r i g h t - a n g l e t u r n .
    remove = ~all(d,2) & (dotprod == 0);
    
    % But we r e a l l y want t o remove the middle p i x e l of the t u r n .
    remove = [remove(end,:); remove(1:end-1,:)];
    
    if ~any(remove)
        done = 1;
    else
        idx = find(remove);
        f(idx(1),:) = [];
    end    
end

