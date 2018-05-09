%% 实现expand操作
function [new_img] = expand(img,w)
    %% 水平方向expand
    [row,col,channel] = size(img);
    tmp_img = zeros(row, 2*col, channel);
    for c = 1:channel
        for i = 1:row
            for j = 1:col
                tmp_img(i, 2*j,c) = img(i,j,c);
            end
            tmp_img(i,:,c) = round(2 * conv2(tmp_img(i,:,c), w, 'same'));
        end
    end
    %% 垂直方向expand
    new_img = zeros(2*row,2*col, channel);
    for c = 1:channel
        for i = 1:row
            new_img(2*i,:,c) = tmp_img(i,:,c);
        end
        
        for j = 1:2*col
            new_img(:,j,c) = round(2*conv2(new_img(:,j,c), w', 'same'));
        end
    end
    end