im = imread('3.jpg');

A = [1 0 0; 0 3 0];
outputIm = backward_geometry(im, A);
figure; imshow(outputIm); title('����');

A =  [  cosd(-30)    -sind(-30)   0; ...
            sind(-30)    cosd(-30)    0];
outputIm = backward_geometry(im, A);
figure;imshow(outputIm);title('��ת') 




function outputIm = backward_geometry(inputIm, A, type)
% inputIm: �����ͼ��
% A: ����任��ϵ����һ��2x3�ľ���

if nargin < 3
    type = 'loose';
end


% ��ȡ����ͼ��Ĵ�С
inputSize = size(inputIm);
if(size(inputIm, 3) == 1)
   inputSize(3) = 1; 
end
row = inputSize(1);
col = inputSize(2);
dim = inputSize(3);


% �������ͼ��Ļ�����С
[outputSize, deltaShift] = calcOutputSize(inputSize, A, type);


AA = A(:, 1:2);
bb = A(:, 3);

new_row = outputSize(1);
new_col = outputSize(2);
outputIm = zeros(new_row, new_col, dim);


% ����ȷ�������������С�����б���
for y = 1 : new_row
    for x = 1 : new_col
        % ��������任�����㵱ǰ��(x,y)������ͼ���е�����
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
            % ˫���Բ�ֵ
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
% type �����֣�һ���� loose�� һ����crop���ο�imrotate����İ����ļ�
% ��Ҫʵ��������
% 'crop'
% Make output image B the same size as the input image A, cropping the rotated image to fit
% {'loose'}
% Make output image B large enough to contain the entire rotated image. B is larger than A


% ��ȡͼ����к��е������������з����Ӧ��y�����з����Ӧ��x����    
ny = inputSize(1);
nx = inputSize(2);

% �����ĸ�������������
inputBoundingBox = [ 1  1 1;...
                    nx  1 1;...
                    nx ny 1;...
                     1 ny 1];
inputBoundingBox = inputBoundingBox';

% ��ȡ����ͼ�񾭹�����任�������ͼ���еĿ�
outputBoundingBox = A * inputBoundingBox;

% �ҵ����ͼ��Ľ��µĿ�
xlo = floor(min(outputBoundingBox(1,:)));
xhi =  ceil(max(outputBoundingBox(1,:)));
ylo = floor(min(outputBoundingBox(2,:)));
yhi =  ceil(max(outputBoundingBox(2,:)));

% sprintf('xlo:%d, xhi:%d, ylo:%d, yhi:%d', xlo, xhi, ylo, yhi)
% �������û�����С�� ��Ҫ�����Լ����
if  strcmp(type, 'crop')
    outputSize = inputSize;
else
    outputSize(1) = yhi - ylo; 
    outputSize(2) = xhi - xlo; 
end


% �����������õĻ�����С������������Ҫ��ӵ�ƫ����deltaShift���Լ����
deltaShift = [-xlo+1; -ylo+1];

end