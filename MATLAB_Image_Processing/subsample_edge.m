function [out] = subsample_edge(B, k)

    %// Obtain boundaries for edge image
    [bound,L,N] = bwboundaries(B);

    out = false(size(B)); %// Initialize output image
    num_edge_points = k; %// Define number of edge points

    %// For each object boundary
    for idx = 1 : N
        boundary = bound{idx}; %// Get boundary

        %// Determine how many points we have
        num_pts = size(boundary,1);

        %// Generate indices for sampling the boundary
        %// If there are less than the minimum, just choose this amount
        if num_pts < num_edge_points
            ind = 1:num_pts;
        else
            ind = floor(linspace(1,num_pts,num_edge_points));
        end

        %// Subsample the edge points
        pts = boundary(ind,:);

        %// Mark points in output
        out(sub2ind(size(B), pts(:,1), pts(:,2))) = true;
    end
end