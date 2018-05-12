function mask = getMask(im, maskname)
% 利用roipoly函数标记一个多边形的区域，生成掩模
% im: 源图像
% maskname: 掩模名称
% mask: 掩模矩阵

figure(1);
[BW, xi, yi] = roipoly(uint8(im));
save(maskname, 'BW', 'xi', 'yi');
mask = load(maskname, 'BW');
mask = double(mask.BW);
