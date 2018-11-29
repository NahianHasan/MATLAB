function [r2,z1] = facerecogpcaeig(datapath)


    %say each person has 20 sample images of his own
    %So, if there are 30 persons in the dataset, there will be in total
    %20*30 = 600 images.
    
    %P . Y     Q-by-K matrix whose rows are the principal compon
    %            ent vectors .
    %
    % P . A      Q - by - n p r i n c ipal components t ra n s f o rmation matrix
    %           whose rows are the a eigenvec tors of ex c o r respond ing
    %           t o the a largest eigenvalues .
    % P . Cx     The n - by - n covariance mat rix of t h e population in X .

    % P . mx     The n - by - 1 mean v e c t o r of t h e population i n X .
    % A          The image matrix of the dataset
    % P . ems    The mean s q u a re e r r o r i n c u r red in u s ing only the a
    %            eigenvectors c o r respond ing to t h e largest
    %            eigenvalu e s . P . ems is 0 if Q = n .
    
    
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
    %[a,b] = size(A)
    
    %K = size(A,1)
    A = double(A);
    
   %%%%% calculating mean image vector %%%%%

    m = mean(A,2); % Computing the average face image m
   % size(A,2)
    %%%%%%%%  calculating A matrix, i.e. after subtraction of all image vectors from the mean image vector %%%%%%

    P = [];
    for i=1 : size(A,2)
        temp = A(:,i) - m;
        P = [P temp];
    end
    %P has subtrcted images in each column
    %[a1,b1] = size(P)
    
    L = P' * P;
    [V,D] = eig(L);
   
    [a2, b2] = size(V)
    
    
    % Sort t h e eigenvalues in decreasing o rd e r . Rearrange t h e
    % e igenvectors t o match .
    d = diag(D);
    [d, idx] = sort(d);
    d = flipud(d);
    idx = flipud(idx);
    
    D = diag(d);
    V = V(:,idx);
    V = V(:,1:390);
    W = P * V;
   
    [a3,b3] = size(W)
    
    % Now form t h e q rows of A f rom t h e f i rst q columns of V .
   %The columns of W are the chosen eigenvectors.
    
    [a4,b4] = size(W)
     %for reconstructing the eigenfaace images
    I = [];
     for i = 1:size(W,2)
        I = W(:,i);
        I1 = reshape(I,r,c);
     end
   
    %Projecting the images in face space(i.e.; eigenface space)
    projectimg = [];  % projected image vector matrix
    for i = 1:size(W,2)
        temp = W' * P(:,i);
        projectimg = [projectimg temp];
    end
    
    
    %%%%% extractiing PCA features of the test image %%%%%
    
    test_image = imread('F:\RATUL\MATLAB Codes\orl_faces\s40\9.pgm');
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
    imshow(g)
end

