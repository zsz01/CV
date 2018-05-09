%% rotate
function [rotate_img] = rotate(img, degree)
% img: 原图片
% degree: 旋转角度
% rotate_img:旋转后的图片 

    if nargin < 2
        degree = 90;
    end
    [row, col, dim] = size(img);
    new_row = ceil(abs(col*cosd(degree)) + abs(row*sind(degree)));
    new_col = ceil(abs(row*cosd(degree)) + abs(col*sind(degree)));
    rotate_img = zeros(new_col, new_row, dim); 

    m1 = [1 0 -0.5*new_col; 0 -1 0.5*new_row; 0 0 1];
    m3 = [1 0 0.5*row; 0 -1 0.5*col; 0 0 1];
    % 旋转矩阵
    m2 = [  cosd(-degree)    -sind(-degree)   0; ...
            sind(-degree)    cosd(-degree)    0; ...
            0               0               1];  
    for new_x = 1:new_row
        for new_y = 1:new_col
            % 将新节点的（x,y）逆着旋转回去，得到旧的坐标（x',y'）
            new_coordinate = [new_x; new_y; 1];
            coord = m3*m2*m1*new_coordinate;
            x = round(coord(1));
            y = round(coord(2));
            if(x <= 0 || y <= 0 || x >row || y > col)
                continue
            end
            rotate_img(new_x, new_y, :) = img(x, y, :);
        end
    end
    rotate_img = rotate_img/255;
end