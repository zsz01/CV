clear; clc;
im = imread('Lena.png');
im = rgb2gray(im);
im = imresize(im, [256 256]);
figure; imshow(im); title("original");


% demo_fourier transform
% construct a 11x11 averaging template
f2 = [zeros(5,11); 1/11*ones(1,11); zeros(5,11)];
%  do the 2d Fourier transform
F2 = fft2(f2);
FS2= fftshift(F2);
figure;subplot(1,3,2);imshow(FS2);title('FS2');

% construct a 11x11 impluse template
f1 =zeros(11,11);
f1(6,6) = 2;
%  do the 2d Fourier transform
F1 = fft2(f1);
FS1 = fftshift(F1);
subplot(1,3,1);imshow(F1);title('FS1');

f3 = f1-f2;
F3 = fft2(f3);
FS3 = fftshift(F3);
subplot(1,3,3);imshow(F3);title('FS3');


f1 =zeros(11,11);
f1(6,6) = 2;
F1 = dct(f1);
figure;subplot(1,3,1)
imshow(F1);title('DCT1')

f2 = [zeros(5,11); 1/11*ones(1,11); zeros(5,11)];
%  do the 2d Fourier transform
F2 = dct(f2);
subplot(1,3,2);imshow(F2);title('DCT2');

f3 = f1-f2;
F3 = dct(f3);
subplot(1,3,3);imshow(F3);title('DCT3');



im=imread('demo.jpg');
im=imresize(im(:,:,1),[256,256]);
figure;subplot(2,2,1);
imshow(im);title("原图");
out1 = conv2(im, F1);
subplot(2,2,2);imshow(out1);title('冲击响应');

out2 = conv2(im, F2);
subplot(2,2,3);imshow(out2);title('运动模糊');

out3 = conv2(im, F3);
subplot(2,2,4);imshow(out3); title('f1-f2');




%%
% 1-1）尝试分析F1，F2，F1-F2的频谱信息
% 1-2）是否和我们先前讲解的例子对应上，你找自己拍摄的一幅照片，缩小成256x256，利用f1,f2,f1-f2进行卷积，观察得到的图像特性？
% 1-3）如果频谱信息和我们所说的对应不上，为什么？


%%
% 2-1）尝试利用离散余弦变换分析f1，f2，f1-f2的频谱信息
% 2-2）如果频谱信息和我们所说的对应不上，为什么？