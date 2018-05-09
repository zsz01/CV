%% scale
function [zoom_img] = zoom(img, s_x, s_y)
% img: 原图片
% s_x: x方向缩放的比例 
% s_y: y方向缩放的比例
% zoom_img: 缩放后的照片
        
    [row, col, dim] = size(img);
    new_row = ceil(col * s_x);
    new_col = ceil(row * s_y);
    zoom_img = zeros(new_col, new_row, dim); 

    m1 = [1 0 -0.5*col; 0 -1 0.5*row; 0 0 1];
    m3 = [1 0 0.5*new_row; 0 -1 0.5*new_col; 0 0 1];
    % 缩放矩阵
    m2 = [  s_x     0           0; ...
            0           s_y     0; ...
            0           0           1];  
        
    for x = 1:col
        for y = 1:row
            coord = [x; y; 1];
            new_coordinate = m3 * m2 * m1 * coord;
            new_x = round(new_coordinate(1));
            new_y = round(new_coordinate(2));
            if (new_x <= 0 || new_y <= 0)
                continue
            end
            zoom_img(new_y, new_x, :) = img(y, x, :);
       end
    end
    zoom_img = zoom_img/255;
end


