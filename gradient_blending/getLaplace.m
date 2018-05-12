function [imLap] = getLaplace(img)
% 返回img经过laplace变换后的矩阵

w = [ 0,  -1,   0; ...
     -1,   4,  -1; ...
      0,  -1,   0];

imLap = img;
for i = 1:size(img, 3)
    imLap(:,:,i) = conv2(img(:,:,i), w, 'same');
end

end

