function [x] = est_optimal_affine(im1,im2)
%%   ����im1 �� im2����任�ľ���
A = [im1(1,1),im1(1,2),1,0,0,0;0,0,0,im1(1,1),im1(1,2),1;...
    im1(2,1),im1(2,2),1,0,0,0;0,0,0,im1(2,1),im1(2,2),1;...
    im1(3,1),im1(3,2),1,0,0,0;0,0,0,im1(3,1),im1(3,2),1;];
b = [im2(1,1);im2(1,2);im2(2,1);im2(2,2);im2(3,1);im2(3,2);];
x = A\b;
x = [x(1:3)' ; x(4:6)'];
end

