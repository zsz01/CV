%% 实现reduce操作
function [new_img] = reduce(img,w)
    %% 水平方向reduce
    [row,col, channel] = size(img);
    new_row = floor(row/2);
    new_col = floor(col/2);
    tmp_img = zeros(row,new_col,channel);
    for c = 1:channel
        for i = 1:row
            I = conv2(img(i,:,c), w, 'same');
            for j = 1:new_col
                tmp_img(i,j,c) = round(I(2*j));
            end
        end
    end
    
    %% 垂直方向reduce
    new_img = zeros(new_row,new_col,channel);
    for c = 1:channel
            for j = 1:new_col
                I = conv2(tmp_img(:,j,c), w', 'same');
                for i = 1:new_row
                new_img(i,j,c) = round(I(2*i));
                end
            end
    end
    end