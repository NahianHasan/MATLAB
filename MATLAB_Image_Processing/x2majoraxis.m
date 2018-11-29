function [B, theta] = x2majoraxis(A, B, type)

    %XPMAJORAXIS Aligns coordinate x with the major aixis o f a region.
    % [B2, THETA] = X2MAJORAXIS(A, B, TYPE) aligns the X-coordinate
    % axis with the major axis of a region or boundary. The y-axis i s
    % perpendicular t o t h e x - a x i s . The rows of 2-by-2 matrix A are the
    % coordinates of the two end points of the major axis, i n the form
    % A = [ x l y l ; x2 y2]. On input, B i s e i t h e r a binary image (i.e.,
    % an array of class l o g i c a l ) containing a sing1.e region, or it i s
    % an np-by-2 set of points representing a (connected) boundary. I n
    % the l a t t e r case, the f i r s t column of B must represent
    % x-coordinates and the second column must represent the
    % corresponding y-coordinates. On output, B contains the same data,
    % as t h e i n p u t , but aligned with the major axis. If t h e i n p u t i s an
    % image, so i s the output; s i m i l a r l y the outpul: i s a sequence of
    % coordinates if t h e i n p u t i s such a sequence. Parameter THETA i s
    % the i n i t i a l angle between the major axis and the x-axis. The
    % o r i g i n of the xy-axis system i s at the bottorn l e f t ; t h e x - a x i s i s
    % the h o r i z o n t a l axis and t h e y - a x i s i s the v e r t i c a l .
    0,
    % Keep i n mind t h a t r o t a t i o n s can introduce round-off errors when
    % the data are converted t o integer coordinates, which i s a
    % requirement. Thus, postprocessing (e.g., with bwmorph) of the
    % output may be required t o reconnect a bounda~ry
    
    %Preliminaries
    if islogical(B)
        type = 'region';
    elseif size(B,2) == 2
        type = 'boundary';
        [M, N] = size(B);
        if M < N
            error('B must be of size np-by-2');
        end
        
        % Compute centroid f o r l a t e r use. c i s a 1-by-2 vector.
        % I t s 1st component i s the mean of the boundary i n the x - d i r e c t i o n .
        % The second i s the mean i n the y - d i r e c t i o n .
        c(1) =  round((min(B(:,1)) + max(B(:,1))) / 2);
        c(2) =  round((min(B(:,2)) + max(B(:,2))) / 2);
        
        % It i s possible f o r a connected boundary t o develop small breaks
        % a f t e r r o t a t i o n . To prevent t h i s , the input boundary i s f i l l e d ,
        % processed as a region, and then the boundary i s re-extracted. This
        % guarantees t h a t the output w i l l be a connected boundary.
        m = max(size(B));
        % The following image i s o f s i z e m-by-m t o ma~ke sure that there
        % there w i l l be no s i z e t r u n c a t i o n a f t e r r o t a t i o n .
        B = boundaries(B,m,m);
        B = imfill(B,'holes');
        
    else
        error('Input must be a boundary or a region');
    end
    
    %Major Axis in vector form
    v(1) = A(2,1) - A(1,1);
    v(2) = A(2,2) - A(1,2);
    v = v(:);
    %unit vector along x axis
    u = [1 ; 0];
    % The following image i s o f s i z e m-by-m t o ma~ke sure that there
    % there w i l l be no s i z e t r u n c a t i o n a f t e r r o t a t i o n .
    nv = norm(v);
    nu = norm(u);
    theta = acos(u'*v / (nv*nu));
    if theta > pi/2
        theta = -(theta - pi/2);
    end
    theta = theta * 180/pi;% convert to degrees
    
    %Rotate by theta degrees and crop the image to original size
    B = imrotate(B,theta, 'bilinear', 'crop');
    
    %If the input was a boundary reextract it
    if strcmp(type, 'boundary')
        B = boundaries(B);
        B = B{1};
        % S h i f t so t h a t centroid of the extracted boundary i s
        % approx equal t o the centroid of the o r i g i n a l boundary:
        B(:,1) = B(:, 1) - min(B(:,1)) + c(1);
        B(:,2) = B(:, 2) - min(B(:,2)) + c(2);
    end
end

