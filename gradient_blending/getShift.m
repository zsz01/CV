function [imA_shift, maskA_shift] = getShift(imA, maskA, mask_name, imB)
%% 利用ginput在目标图像imB中点击一个点，将源图像的区域imA maskA的中心点对齐到这个点

% 获取一个位置信息
figure(1);imshow(uint8(imB));
[xshift,yshift] = ginput(1);

% 获取原始图像中偏移量
maskPoints = load(mask_name, 'xi', 'yi');
xshift = (xshift - mean(maskPoints.xi));
yshift = (yshift - mean(maskPoints.yi));

% 将图像A和它的模板都进行平移
imA_shift = imtranslate(imA, [xshift, yshift]);
maskA_shift = imtranslate(maskA, [xshift, yshift]);