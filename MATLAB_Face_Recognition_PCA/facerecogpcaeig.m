function [projectimg,W,m,numimg] = facerecogpcaeig(varargin)
    
    if (length(varargin) == 0)
        error('Specify the database directory Path.');
        return;
    elseif (length(varargin) == 1)
        datapath = varargin{1};
        f = 40;
        numimg = 10;
        k = numimg;
    elseif (length(varargin) == 2)
        datapath = varargin{1};
        f = varargin{2};
        numimg = 10
        k = numimg;
    elseif (length(varargin) == 3)
        datapath = varargin{1};
        f = varargin{2};
        numimg = varargin{3};
        k = numimg;
    end
        
    A = [];    
    for j = 1:f
        for i = 1:k
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
    original_eig_vect = [];
    for i = 1:size(V,2)
        c = P * V(:,i);
        original_eig_vect = [original_eig_vect c];
    end
    original_eig_vect;
    
    % Sort t h e eigenvalues in decreasing o rd e r . Rearrange the igenvectors t o match .
    d = diag(D);
    [d, idx] = sort(d);
    d = flipud(d);
    idx = flipud(idx);
    
    D = diag(d);
    original_eig_vect = original_eig_vect(:, idx);
    q = size(original_eig_vect,2);
    W = original_eig_vect(:,1:q);%The columns of W are the chosen eigenvectors.

    %Projecting the images in face space(i.e.; eigenface space)
   projectimg = [];  % projected image vector matrix
    for i = 1:size(W,2)
        temp = [];
        for j = 1:size(W,2)
            c1 = (W(:,j))' * P(:,i);
            temp = [temp c1];
        end
        temp = temp';
        projectimg = [projectimg temp];
    end
  
end

