clear; clc;
img = imread ('photo.jpg');
% figure; subplot(121);imshow(img,[]); title("original");
img = rgb2gray(img); 
img = double (img);
% subplot(122); imshow(img,[]); title("gray");

%% Step1: 对图像 求x、y方向梯度 再用模版卷积平滑 

% Gaussian滤波器
G = [   2,  4,  5,  4,  2;
        4,  9,  12, 9,  4;
        5,  12, 15, 12, 5;
        4,  9,  12, 9,  4;
        2,  4,  5,  4,  2];
G = 1/159 .* G;

% 一阶差分滤波器
dx = [1, 0, -1];
dy = [1; 0; -1];


Gx = conv2(G, dx, 'full');
Gy = conv2(G, dy, 'full');

% x、y方向梯度
Ix = conv2(img, Gx, 'same');
Iy = conv2(img, Gy, 'same');
% figure;
% subplot(131); imshow(Ix,[]); title('Ix');
% subplot(132); imshow(Iy,[]); title('Iy');

%% Step2: 计算梯度强度
magnitude = sqrt(Ix.*Ix + Iy.*Iy);
% subplot(133); imshow(magnitude,[]); title('magnitude');


%% Step3: 计算梯度方向
angle = atan2(Iy, Ix);
% figure; hold on; quiver(Ix, Iy, 'b'); quiver(-Iy, Ix, 'r'); quiver(Iy, -Ix, 'r'); title('direction');
% set(gca, 'YDir', 'reverse');

%% Step4: 非极大值抑制，保留梯度方向强度的极大值点，将模糊的边界变得清晰

% 限制梯度方向为4个离散的方向以简化
angle(angle < 0) = pi + angle(angle < 0);
angle(angle > 7*pi/8) = pi - angle(angle > 7*pi/8);

angle(angle >= 0    & angle < pi/8) = 0;
angle(angle >= pi/8 & angle < 3*pi/8) = pi/4;
angle(angle >= 3*pi/8 & angle < 5*pi/8) = pi/2;
angle(angle >= 5*pi/8 & angle <= 7*pi/8) = 3*pi/4;

% NMS
[m, n] = size(img);
edge = zeros(m, n);
edge = non_maximum_suppression(magnitude, angle, edge); 
% figure; imshow(edge,[]); title('edge');


%% Step5: 双阈值的滞后边界跟踪法，检测并连接边缘

threshold_low = 0.1;
threshold_high = 0.2;
threshold_low = threshold_low * max(edge(:));
threshold_high = threshold_high * max(edge(:));  


%% TODO:  把梯度也传进去，然后在切线方向上进行连接

linked_edge1 = hysteresis_thresholding1(threshold_low, threshold_high, edge);
figure; imshow(linked_edge1,[]); title('link1');

linked_edge = hysteresis_thresholding(threshold_low, threshold_high, edge, angle);
figure; imshow(linked_edge,[]); title('link');