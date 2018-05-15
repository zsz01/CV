function descps = extractNccFeature(img, Locs, halfsz)
%% ����һ������ÿ��������������ľ���
% parse the input parameters
if(~exist('halfsz','var'))
   halfsz = [12,12];
else
    if(length(halfsz) <= 1)
        halfsz = [halfsz, halfsz];
    else
        halfsz = halfsz(1:2);
    end
end
halfsz = round(halfsz);
halfsz(halfsz<1) = 1;

%% 
nc = size(img,3);
dim = prod(2*halfsz+1);
descps = zeros(size(Locs,1), nc * dim);  %��2*halfsz+1�����ڵĵ㰴˳��ŵ�һ��������
img = double(img);

for i = 1 : size(Locs,1)
    x = Locs(i,1);
    y = Locs(i,2);
    
    xlo = max([1, x - halfsz(1)]);
    xhi = min([size(img,2), x + halfsz(1)]);
    ylo = max([1, y - halfsz(2)]);
    yhi = min([size(img,1), y + halfsz(2)]);
    
    % xΪcol��yΪrow
    for x = xlo:xhi
        for y = ylo:yhi
            for c = 1:nc
                index = (c-1)*dim+(y-ylo)*(halfsz(1)*2+1)+(x-xlo+1);
                descps(i,index) = img(y,x,c);
            end
        end
    end
end

% do the normalization
descps = descps - repmat(mean(descps,2),[1 nc * dim]);
descps = descps ./ repmat(sqrt(sum(descps.^2,2)+1e-20),[1 nc*dim]);