pp=imread('phm.jpg'); %��ȡͼ��
subplot(1,5,1)
imshow(pp);
title('ԭͼ��');

[m,n]=size(pp); 
pp=imnoise(pp);%������ 
subplot(1,5,2);
imshow(pp);
title('ͼ�������');

w=fspecial('gaussian',[9 9]);
pp=imfilter(pp, w, 'replicate');%�˲�
subplot(1,5,3);
imshow(pp);
title('�˲�');

pp=rgb2gray(pp);
pa = edge(pp,'canny');
subplot(1,5,4);
imshow(pa);
title('canny��Ե���õ���ͼ��');
