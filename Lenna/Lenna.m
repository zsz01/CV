% 读取、显示Lenna.png
im = imread('Lenna.png');
figure
imshow(im)
title('Lenna')

% 使用help imresize命令查看用法
help imresize
% 将Lenna.png放大3倍，存储为Lenna3.png
im3 = imresize(im, 3);
figure
imshow(im3)
title('放大三倍')
saveas(gcf, 'Lenna3.png')

% 将Lenna.png向左平移两个像素，存储为Lenna2.png
[~, col_1, ~] = size(im);
im2 = im(:, 3:col_1, :);
[~, col_2, ~] = size(im2);
sprintf('平移前宽度为%d,平移后宽度为%d', col_1, col_2)
figure
imshow(im2)
title('向左平移两个像素')
saveas(gcf, 'Lenna2.jpg')
