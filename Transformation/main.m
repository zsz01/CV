A = imread('source.jpg');
B = affine(A, 1,1 , 0, 1, 2, 0);
figure()
title('affine')
imshow(B)

tform = affine2d([1 1 0; 1 2 0; 0 0 1]');
B = imwarp(A, tform);
figure
imshow(B)

% B = zoom(A, 2, 2);
% figure()
% title('zoom')
% imshow(B)
% 
% %% affine
% function [affine_img] = affine(img, a1, b1, c1, a2, b2, c2)
% % img: ‘≠Õº∆¨
% % u = a1*x + b1*y + c1
% % v = a2*x + b2*y + c2
% % affine_img: ∑¬…‰∫ÛÕº∆¨
% 
%     [row, col, dim] = size(img);
%     new_row = ceil(abs(col*a1) + abs(row*b1) + abs(c1));
%     new_col = ceil(abs(col*a2) + abs(row*b2) + abs(c2));
%     affine_img = zeros(new_col, new_row, dim); 
% 
%     m1 = [1 0 -0.5*col; 0 -1 0.5*row; 0 0 1];
%     m3 = [1 0 0.5*new_row; 0 -1 0.5*new_col; 0 0 1];
%     % ∑¬…‰æÿ’Û
%     m2 = [  a1  b1  c1; ...
%             a2  b2  c2; ...
%             0   0   1];  
%         
%     for x = 1:col
%         for y = 1:row
%             coord = [x; y; 1];
%             new_coordinate = m3 * m2 * m1 * coord;
%             new_x = round(new_coordinate(1));
%             new_y = round(new_coordinate(2));
%             if (new_x <= 0 || new_y <= 0)
%                 continue
%             end
%             affine_img(new_y, new_x, :) = img(y, x, :);
%        end
%     end
%     affine_img = affine_img/255;
% 
% end
