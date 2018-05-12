function [imBlend] = getBlending(imA, imB, mask)
% imA: 源图像的拉普拉斯图像
% imB: 背景图像
% mask: 源图像掩码
% imBlend: ROI区域对应的值

%% 获取ROI区域点数
[m, n, c] = size(imA);
id = zeros(m, n);
num = 0;
for i = 1+1:m-1
    for j = 1+1:n-1
        if(mask(i,j) ~= 0)
            num = num + 1;
            id(i,j) = num;
        end
    end
end

%% 构造A*x=b 的参数
b = zeros(num, c);
x = zeros(num, c);

%稀疏矩阵构造
rowList = zeros(num*5,1);
colList = zeros(num*5,1);
valList = zeros(num*5,1);

% 构造矩阵A的参数
number = 1;
for i = 1+1:m-1
    for j = 1+1:n-1
        % 目标部分
        if(id(i,j) ~= 0)
            for ch = 1:c
                b(id(i,j), ch) = imA(i, j, ch);
            end
            
            rowList(number) = id(i,j);
            colList(number) = id(i,j);
            valList(number) = 4;
            number = number + 1;
            
            % 目标上
            if(id(i-1,j) ~= 0)
                rowList(number) = id(i,j);
                colList(number) = id(i-1,j);
                valList(number) = -1;
                number = number + 1;
            else
                for ch = 1:c
                    b(id(i,j),ch) = b(id(i,j),ch) + imB(i-1,j,ch);
                end
            end
            
            % 目标下
            if(id(i+1,j) ~= 0)
                rowList(number) = id(i,j);
                colList(number) = id(i+1,j);
                valList(number) = -1;
                number = number + 1;
            else
                for ch = 1:c
                    b(id(i,j),ch) = b(id(i,j),ch) + imB(i+1,j,ch);
                end
            end
            
            % 目标左
            if(id(i,j-1) ~= 0)
                rowList(number) = id(i,j);
                colList(number) = id(i,j-1);
                valList(number) = -1;
                number = number + 1;
            else
                for ch = 1:c
                    b(id(i,j),ch) = b(id(i,j),ch) + imB(i,j-1,ch);
                end
            end
            
            % 目标右
            if(id(i,j+1) ~= 0)
                rowList(number) = id(i,j);
                colList(number) = id(i,j+1);
                valList(number) = -1;
                number = number + 1;
            else
                for ch = 1:c
                    b(id(i,j),ch) = b(id(i,j),ch) + imB(i,j+1,ch);
                end
            end
        end
    end
end

% 截取非零元素
number = number - 1;
rowList = rowList(1:number);
colList = colList(1:number);
valList = valList(1:number);

A = sparse(rowList, colList, valList);

%% 计算x的值
for c = 1:c
    x(:,c) = A \ b(:,c);
end

%% 将赋值到imblend
imBlend = imB;
num = 1;
for i = 1+1:m-1
    for j = 1+1:n-1
        if(id(i,j) ~= 0)
            for ch = 1:c
                imBlend(i,j,ch) = x(num,ch);
            end
            num = num + 1;
        end
    end
end
