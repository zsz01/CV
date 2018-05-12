function [] = genMask(path_name, save_name)
    if nargin < 1
        path_name = 'key.jpg';
        save_name = 'key.mat';
    end
    % 读入一幅图像，利用Matlab的roipoly函数标记一个多边形的区域
    im = imread(path_name); 
    
    [BW, xi, yi] = roipoly(im);
    save(save_name,'BW','xi','yi');