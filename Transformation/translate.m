%% translate
function [trans_img] = translate(img, t_x, t_y)
% img: ԭͼ��
% trans_x: x����ƽ��
% trans_y: y����ƽ��
% trans_img: ƽ�ƺ��ͼ��
    
    [row, col, dim] = size(img);
    new_row = row;
    new_col = col;
    trans_img = zeros(new_row, new_col, dim); 

    m1 = [1 0 -0.5*col; 0 -1 0.5*row; 0 0 1];
    m3 = [1 0 0.5*new_col; 0 -1 0.5*new_row; 0 0 1];
    % ƽ�ƾ���
    m2 = [  1   0   t_x; ...
            0   1   t_y; ...
            0   0   1];  
        
    for x = 1:col
        for y = 1:row
            coord = [x; y; 1];
            new_coordinate = m3 * m2 * m1 * coord;
            new_x = round(new_coordinate(1));
            new_y = round(new_coordinate(2));
            if (new_x <= 0 || new_y <= 0)
                continue
            end
            trans_img(new_y, new_x, :) = img(y, x, :);
       end
    end
    trans_img = trans_img/255;
end