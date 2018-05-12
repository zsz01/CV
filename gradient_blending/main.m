%% ��ʼ��
clear; clc;
warning off;
imA_name = 'ppp.jpg';
maskA_name = 'ppp.mat';
imB_name = 'yhz.jpg';
imA = double(imread(imA_name));
imB = double(imread(imB_name));

%% ����imA������
maskA = getMask(imA, maskA_name);

%% ����imA��������˹ͼ��
imALap = getLaplace(imA);

%% ͳһimALap��maskA��imB�ߴ�
[imA_pad, maskA_pad, imB_pad] = getPad(imALap, maskA, imB);

%% ��imB_pad��ѡ��һ���㣬������ͼ��ROI�����ĵ���֮����
[imA_shift, maskA_shift] = getShift(imA_pad, maskA_pad, maskA_name, imB_pad);

%% �ϳ�ͼ��
imblending = getBlending(imA_shift, imB_pad, maskA_shift);
figure(1); imshow(uint8(imblending));
imwrite(uint8(imblending),'imblending.jpg');