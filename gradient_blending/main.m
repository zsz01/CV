%% 初始化
clear; clc;
warning off;
imA_name = 'ppp.jpg';
maskA_name = 'ppp.mat';
imB_name = 'yhz.jpg';
imA = double(imread(imA_name));
imB = double(imread(imB_name));

%% 生成imA的掩码
maskA = getMask(imA, maskA_name);

%% 计算imA的拉普拉斯图像
imALap = getLaplace(imA);

%% 统一imALap、maskA、imB尺寸
[imA_pad, maskA_pad, imB_pad] = getPad(imALap, maskA, imB);

%% 在imB_pad中选择一个点，将填充后图像ROI的中心点与之对齐
[imA_shift, maskA_shift] = getShift(imA_pad, maskA_pad, maskA_name, imB_pad);

%% 合成图像
imblending = getBlending(imA_shift, imB_pad, maskA_shift);
figure(1); imshow(uint8(imblending));
imwrite(uint8(imblending),'imblending.jpg');