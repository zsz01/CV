pp=imread('phm.jpg'); %¶ÁÈ¡Í¼Ïñ
subplot(1,5,1)
imshow(pp);
title('Ô­Í¼Ïñ');

[m,n]=size(pp); 
pp=imnoise(pp);%¼ÓÔëÉù 
subplot(1,5,2);
imshow(pp);
title('Í¼Ïñ¼ÓÔëÉù');

w=fspecial('gaussian',[9 9]);
pp=imfilter(pp, w, 'replicate');%ÂË²¨
subplot(1,5,3);
imshow(pp);
title('ÂË²¨');

pp=rgb2gray(pp);
pa = edge(pp,'canny');
subplot(1,5,4);
imshow(pa);
title('canny±ßÔµ¼ì²âµÃµ½µÄÍ¼Ïñ');
