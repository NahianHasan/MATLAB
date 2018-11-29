tic
clear all
close all
clc
datapath = 'F:\RATUL\MATLAB Codes\orl_faces';
test_image = imread('F:\RATUL\MATLAB Codes\orl_faces\s34\10.pgm');



[weight_matrix,eig_vect,mean,numimg] = facerecogpcaeig(datapath,40,7);
[test_vector] = testimage(test_image,eig_vect,mean);

 %%%%% calculating & comparing the euclidian distance of all projected trained images from the projected test image %%%%%
    
euclid_dist = [];
    for i = 1:size(weight_matrix,2)
        c = weight_matrix(:,i);
        temp = (norm(test_vector-c))^2;
        euclid_dist = [euclid_dist temp];
    end
    [euclide_dist_min index] = min(euclid_dist);
    r3 = rem(index,numimg);
    index1 = index - r3;
    z3 = index1 / numimg;
    if r3 == 0
        z1 = z3;
        r2 = numimg;
    else
        z1 = z3+1;
        r2 = r3;
    end
    str = strcat(datapath,'\','s',int2str(z1),'\',int2str(r2),'.pgm');
    g = imread(str);
    figure, imshow(test_image);
    gcf;
    title('Test Image')
    figure, imshow(g)
    gcf;
    title('Matched Image')
    
    toc