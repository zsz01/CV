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
imshow(im);title("ԭͼ");
out1 = conv2(im, F1);
subplot(2,2,2);imshow(out1);title('�����Ӧ');

out2 = conv2(im, F2);
subplot(2,2,3);imshow(out2);title('�˶�ģ��');

out3 = conv2(im, F3);
subplot(2,2,4);imshow(out3); title('f1-f2');




%%
% 1-1�����Է���F1��F2��F1-F2��Ƶ����Ϣ
% 1-2���Ƿ��������ǰ��������Ӷ�Ӧ�ϣ������Լ������һ����Ƭ����С��256x256������f1,f2,f1-f2���о�����۲�õ���ͼ�����ԣ�
% 1-3�����Ƶ����Ϣ��������˵�Ķ�Ӧ���ϣ�Ϊʲô��


%%
% 2-1������������ɢ���ұ任����f1��f2��f1-f2��Ƶ����Ϣ
% 2-2�����Ƶ����Ϣ��������˵�Ķ�Ӧ���ϣ�Ϊʲô��