function [imLap] = getLaplace(img)
% ����img����laplace�任��ľ���

w = [ 0,  -1,   0; ...
     -1,   4,  -1; ...
      0,  -1,   0];

imLap = img;
for i = 1:size(img, 3)
    imLap(:,:,i) = conv2(img(:,:,i), w, 'same');
end

end

