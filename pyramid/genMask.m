function [] = genMask(path_name, save_name)
    if nargin < 1
        path_name = 'key.jpg';
        save_name = 'key.mat';
    end
    % ����һ��ͼ������Matlab��roipoly�������һ������ε�����
    im = imread(path_name); 
    
    [BW, xi, yi] = roipoly(im);
    save(save_name,'BW','xi','yi');