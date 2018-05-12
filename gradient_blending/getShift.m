function [imA_shift, maskA_shift] = getShift(imA, maskA, mask_name, imB)
%% ����ginput��Ŀ��ͼ��imB�е��һ���㣬��Դͼ�������imA maskA�����ĵ���뵽�����

% ��ȡһ��λ����Ϣ
figure(1);imshow(uint8(imB));
[xshift,yshift] = ginput(1);

% ��ȡԭʼͼ����ƫ����
maskPoints = load(mask_name, 'xi', 'yi');
xshift = (xshift - mean(maskPoints.xi));
yshift = (yshift - mean(maskPoints.yi));

% ��ͼ��A������ģ�嶼����ƽ��
imA_shift = imtranslate(imA, [xshift, yshift]);
maskA_shift = imtranslate(maskA, [xshift, yshift]);