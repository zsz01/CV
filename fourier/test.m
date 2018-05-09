clear; clc;
im = imread('demo.jpg');
im = imresize(im,[256 256]);
% figure;subplot(1,2,1);imshow(im);title('color');
im = rgb2gray(im);
im = imresize(im, [256 256]);
% subplot(1,2,2); imshow(im); title("gray");


%% FFT
% impluse template
f1 = zeros(11, 11);
f1(6, 6) = 2;
C1 = conv2(im, f1);
F1 = fft2(f1);
FS1 = fftshift(F1);  % 将低频零点移至图像中心

% averaging template
f2 = [  zeros(5,11); ...
        1/11*ones(1,11); ...
        zeros(5,11)];
C2 = conv2(im, f2);
F2 = fft2(f2);
FS2 = fftshift(F2);

% delta
f3 = f1 - f2;
C3 = conv2(im, f3);
F3 = fft2(f3);
FS3 = fftshift(F3);


%% DCT
% impluse template
D1 = dct2(f1);
% averaging template
D2 = dct2(f2);
% delta
D3 = dct2(f3);


%% plot
figure;

%Conv
subplot(3,3,1); imshow(C1,[]); title("Conv1");  
subplot(3,3,2); imshow(C2,[]); title("Conv2");
subplot(3,3,3); imshow(C3,[]); title("Conv3");

% FFT
subplot(3,3,4); imshow(abs(FS1),[]); title("FFT1");  
subplot(3,3,5); imshow(abs(FS2),[]); title("FFT2");  
subplot(3,3,6); imshow(abs(FS3),[]); title("FFT3");

% DCT
subplot(3,3,7); imshow(D1,[]); title("DCT1");
subplot(3,3,8); imshow(D2,[]); title("DCT2");
subplot(3,3,9); imshow(D3,[]); title("DCT3");
 

