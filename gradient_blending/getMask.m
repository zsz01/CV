function mask = getMask(im, maskname)
% ����roipoly�������һ������ε�����������ģ
% im: Դͼ��
% maskname: ��ģ����
% mask: ��ģ����

figure(1);
[BW, xi, yi] = roipoly(uint8(im));
save(maskname, 'BW', 'xi', 'yi');
mask = load(maskname, 'BW');
mask = double(mask.BW);
