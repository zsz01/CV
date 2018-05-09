A = imread('source.jpg');
B = myaffine(A, 1, 1, 0, 1, 2, 0);
figure()
title('affine')
imshow(B)

tform = affine2d([1 1 0; 1 2 0; 0 0 1]');
B = imwarp(A, tform);
figure
imshow(B)

%% affine
function [affine_img] = myaffine(img, a1, b1, c1, a2, b2, c2)
% img: ‘≠Õº∆¨
% u = a1*x + b1*y + c1
% v = a2*x + b2*y + c2
% affine_img: ∑¬…‰∫ÛÕº∆¨

    [row, col, dim] = size(img);
    new_row = ceil(abs(row*a1) + abs(col*b1) + abs(c1));
    new_col = ceil(abs(row*a2) + abs(col*b2) + abs(c2));
    affine_img = zeros(new_row, new_col, dim); 

    m1 = [1 0 -1; 0 1 -1; 0 0 1];
    m3 = [1 0 1; 0 1 1; 0 0 1];
    ret = [1 0 0; 0 -1 0; 0 0 1];
    % ∑¬…‰æÿ’Û
    m2 = [  a1  b1  c1; ...
            a2  b2  c2; ...
            0   0   1];  
        
    for new_x = 1:new_row
        for new_y = 1:new_col
            new_coord = [new_x; new_y; 1];
            coordinate = m3 * ret * inv(m2) *ret* m1 * new_coord;
            x = round(coordinate(1));
            y = round(coordinate(2));
            if (x <= 0 || y <= 0 || x > row || y > col)
                continue;
            end
            affine_img(new_x, new_y, :) = img(x, y, :);
       end
    end
    affine_img = affine_img/255;

end
