%% 初始化
clear; clc;
warning off;
imA_name = 'apple.jpg';
maskA_name = 'apple.mat';
imB_name = 'apple.jpg';
imA = double(imread(imA_name));
imB = double(imread(imB_name));

%% 生成imA的掩码
maskA = getMask(imA, maskA_name);

%% 计算imA的拉普拉斯图像
imALap = getLaplace(imA);

%% 统一imALap、maskA、imB尺寸
[imA_pad, maskA_pad, imB_pad] = getPad(imALap, maskA, imB);

for i = 1:2
%% 在imB_pad中选择一个点，将填充后图像ROI的中心点与之对齐
[imA_shift, maskA_shift] = getShift(imA_pad, maskA_pad, maskA_name, imB_pad);

%% 合成图像
imblending = getBlending(imA_shift, imB_pad, maskA_shift);
imB_pad = imblending;
end
figure(1); imshow(uint8(imblending));
imwrite(uint8(imblending),'imblending.jpg');