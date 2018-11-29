function [r2,z1] = facerecogpcaeig(datapath)
    %r2th image of folder s'z' has been found as a match
    
    D = dir(datapath);
    imcount = 0;
    for i = 1:size(D,1)
        if not(strcmp(D(i).name,'.') | strcmp(D(i).name, '..') | strcmp(D(i).name, 'Thumbs.db'))
            imcount = imcount + 1;
        end
    end
   % imcount
    A = [];
    for j = 1:40
        for i = 1:10
            str = strcat(datapath, '\', 's',int2str(j),'\', int2str(i), '.pgm');
            img = imread(str);
            [r, c] = size(img);
            temp = reshape(img, r*c, 1);
            A = [A temp];
        end
    end
   
    A = double(A);
    
    m = mean(A,2); % Computing the average face image m

    P = [];
    for i=1 : size(A,2)
        temp = A(:,i) - m;
        P = [P temp];
    end
    %P has subtrcted images in each column [a1,b1] = size(P)
    
    L = P' * P;
    [V,D] = eig(L);
    original_eig_vect = P * V;
    
    % Sort t h e eigenvalues in decreasing o rd e r . Rearrange the igenvectors t o match .
    d = diag(D);
    [d, idx] = sort(d);
    d = flipud(d);
    idx = flipud(idx);
    
    D = diag(d);
    original_eig_vect = original_eig_vect(:, idx);
    
    W = original_eig_vect(:,1:400);%The columns of W are the chosen eigenvectors.
    
    %for reconstructing the eigenface images to just see the images
    I = [];
    for i = 1:size(W,2)
        I = W(:,i);
        I1 = reshape(I,r,c);
        if i<40
            figure,imshow(I1)
        end
    end
   
    %Projecting the images in face space(i.e.; eigenface space)
    projectimg = [];  % projected image vector matrix
    for i = 1:size(W,2)
        temp = W' * P(:,i);
        projectimg = [projectimg temp];
    end
    
    
    %%%%% extractiing PCA features of the test image %%%%%
    
    test_image = imread('F:\RATUL\MATLAB Codes\orl_faces\s40\10.pgm');
    [r1 c1] = size(test_image)
    imshow(test_image)
    temp = reshape(test_image,r1*c1,1); % creating (MxN)x1 image vector from the 2D image
    temp1 = double(temp);
    temp2 = temp1-m; % mean subtracted vector
    projtestimg = W'*temp2; % projection of test image onto the facespace
    
    %%%%% calculating & comparing the euclidian distance of all projected trained images from the projected test image %%%%%
  
    euclid_dist = [];
    for i = 1:size(W,2)
        c = projectimg(:,i);
        temp = (norm(projtestimg-c));
        euclid_dist = [euclid_dist temp];
    end
    [euclide_dist_min index] = min(euclid_dist)
    r2 = rem(index,10);
    index1 = index - r2;
    z = index1 / 10;
    if r2 == 0
        z1 = z;
        r2 = 10;
    else
        z1 = z+1;
    end
    str = strcat(datapath,'\','s',int2str(z1),'\',int2str(r2),'.pgm');
    g = imread(str);
    figure, imshow(g)
  
end

