im = imread('3.jpg');

A = [1 0 0; 0 3 0];
outputIm = backward_geometry(im, A);
figure; imshow(outputIm); title('缩放');

A =  [  cosd(-30)    -sind(-30)   0; ...
            sind(-30)    cosd(-30)    0];
outputIm = backward_geometry(im, A);
figure;imshow(outputIm);title('旋转') 




function outputIm = backward_geometry(inputIm, A, type)
% inputIm: 输入的图像
% A: 仿射变换的系数，一个2x3的矩阵

if nargin < 3
    type = 'loose';
end


% 获取输入图像的大小
inputSize = size(inputIm);
if(size(inputIm, 3) == 1)
   inputSize(3) = 1; 
end
row = inputSize(1);
col = inputSize(2);
dim = inputSize(3);


% 计算输出图像的画布大小
[outputSize, deltaShift] = calcOutputSize(inputSize, A, type);


AA = A(:, 1:2);
bb = A(:, 3);

new_row = outputSize(1);
new_col = outputSize(2);
outputIm = zeros(new_row, new_col, dim);


% 根据确定的输出画布大小来进行遍历
for y = 1 : new_row
    for x = 1 : new_col
        % 进行逆向变换，计算当前点(x,y)在输入图像中的坐标
        old_coordinate = AA \ ([x; y] - bb - deltaShift);
        x0 = old_coordinate(1);
        y0 = old_coordinate(2);
        
        top = floor(y0);
        bottom = ceil(y0);
        left = floor(x0);
        right = ceil(x0);
        
        if top < 1 || bottom > row || left < 1 || right > col
            outputIm(y, x, :) = 0;
        else
            % 双线性插值
            a = x0 - left;
            b = y0 - top;

            outputIm(y, x, :) = inputIm(top, left, :) * (1-a)*(1-b) + ...
                                inputIm(top, right, :) * a*(1-b) + ...
                                inputIm(bottom, left, :) * (1-a)*b + ...
                                inputIm(bottom, right, :) * a*b;    
        end
    end
end
outputIm = outputIm/255;
end


function [outputSize, deltaShift] = calcOutputSize(inputSize, A, type)
% type 有两种，一种是 loose， 一种是crop，参考imrotate命令的帮助文件
% 需要实现这两种
% 'crop'
% Make output image B the same size as the input image A, cropping the rotated image to fit
% {'loose'}
% Make output image B large enough to contain the entire rotated image. B is larger than A


% 获取图像的行和列的总数，其中行方向对应着y方向，列方向对应着x方向    
ny = inputSize(1);
nx = inputSize(2);

% 计算四个顶点的齐次坐标
inputBoundingBox = [ 1  1 1;...
                    nx  1 1;...
                    nx ny 1;...
                     1 ny 1];
inputBoundingBox = inputBoundingBox';

% 获取输入图像经过仿射变换后在输出图像中的框
outputBoundingBox = A * inputBoundingBox;

% 找到输出图像的紧致的框
xlo = floor(min(outputBoundingBox(1,:)));
xhi =  ceil(max(outputBoundingBox(1,:)));
ylo = floor(min(outputBoundingBox(2,:)));
yhi =  ceil(max(outputBoundingBox(2,:)));

% sprintf('xlo:%d, xhi:%d, ylo:%d, yhi:%d', xlo, xhi, ylo, yhi)
% 重新设置画布大小， 需要你们自己添加
if  strcmp(type, 'crop')
    outputSize = inputSize;
else
    outputSize(1) = yhi - ylo; 
    outputSize(2) = xhi - xlo; 
end


% 根据重新设置的画布大小，计算你们需要添加的偏移量deltaShift，自己添加
deltaShift = [-xlo+1; -ylo+1];

end