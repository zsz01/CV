%% ���ɸ�˹��������������˹������
function [] = laplacian_pyramid()
    % ����һ����Ƭ�����и�˹������ ������˹�������ķֽ�
    im = imread('llh.jpg'); 
    nlvls = 4;
    laps = genPyramids(im,nlvls);
    
    % �����еĸ�˹ͼ��ϲ���һ����ͼ��
    xsep = 2;
    ysep = 0;
    szIm = size(im);
    if(size(im,3) == 1) 
        szIm(3) = 1;
    end
    gaussIm = ones(szIm(1), szIm(2) + size(laps{2,1},2) + xsep * 2, szIm(3))*255;
    gaussIm(1: szIm(1), 1 : szIm(2), :) = laps{1,1};
    top = 0; left = szIm(2) + xsep;
    for i = 2 : nlvls
       sz4lvl = size(laps{i,1});
       gaussIm( top + (1 : sz4lvl(1)),...
                left + (1 : sz4lvl(2)),...
                :) = laps{i,1};
       top = top + ysep + sz4lvl(1);
    end
    figure(1);imshow(uint8(gaussIm));
    
    % �����е�������˹ͼ��ϲ���һ����ͼ��
    lapIm = ones(szIm(1), szIm(2) + size(laps{2,1},2) + xsep, szIm(3))*255;
    lapIm(1: szIm(1), 1 : szIm(2), :) = laps{1,2};
    top = 0; left = szIm(2) + xsep;
    for i = 2 : nlvls
       sz4lvl = size(laps{i,1});
       lapIm( top + (1 : sz4lvl(1)),...
                left + (1 : sz4lvl(2)),...
                :) = laps{i,2};
       top = top + ysep + sz4lvl(1);
    end
    figure(2);imshow(uint8(lapIm + 127));