function [projtestimg] = testimage(test_image,W,m)

    [r1 c1] = size(test_image);
    temp = reshape(test_image,r1*c1,1); % creating (MxN)x1 image vector from the 2D image
    temp1 = double(temp);
    temp2 = temp1-m; % mean subtracted vector
    % projection of test image onto the facespace
    projtestimg = [];
    tem = [];
        for j = 1:size(W,2)
            c1 = (W(:,j))' * temp2;
            tem = [tem c1];
        end
        tem = tem';
    projtestimg = [projtestimg tem];
end

