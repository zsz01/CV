% ��ȡ����ʾLenna.png
im = imread('Lenna.png');
figure
imshow(im)
title('Lenna')

% ʹ��help imresize����鿴�÷�
help imresize
% ��Lenna.png�Ŵ�3�����洢ΪLenna3.png
im3 = imresize(im, 3);
figure
imshow(im3)
title('�Ŵ�����')
saveas(gcf, 'Lenna3.png')

% ��Lenna.png����ƽ���������أ��洢ΪLenna2.png
[~, col_1, ~] = size(im);
im2 = im(:, 3:col_1, :);
[~, col_2, ~] = size(im2);
sprintf('ƽ��ǰ���Ϊ%d,ƽ�ƺ���Ϊ%d', col_1, col_2)
figure
imshow(im2)
title('����ƽ����������')
saveas(gcf, 'Lenna2.jpg')
