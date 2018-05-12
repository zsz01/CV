function [imBlend] = getBlending(imA, imB, mask)
% imA: Դͼ���������˹ͼ��
% imB: ����ͼ��
% mask: Դͼ������
% imBlend: ROI�����Ӧ��ֵ

%% ��ȡROI�������
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

%% ����A*x=b �Ĳ���
b = zeros(num, c);
x = zeros(num, c);

%ϡ�������
rowList = zeros(num*5,1);
colList = zeros(num*5,1);
valList = zeros(num*5,1);

% �������A�Ĳ���
number = 1;
for i = 1+1:m-1
    for j = 1+1:n-1
        % Ŀ�겿��
        if(id(i,j) ~= 0)
            for ch = 1:c
                b(id(i,j), ch) = imA(i, j, ch);
            end
            
            rowList(number) = id(i,j);
            colList(number) = id(i,j);
            valList(number) = 4;
            number = number + 1;
            
            % Ŀ����
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
            
            % Ŀ����
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
            
            % Ŀ����
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
            
            % Ŀ����
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

% ��ȡ����Ԫ��
number = number - 1;
rowList = rowList(1:number);
colList = colList(1:number);
valList = valList(1:number);

A = sparse(rowList, colList, valList);

%% ����x��ֵ
for c = 1:c
    x(:,c) = A \ b(:,c);
end

%% ����ֵ��imblend
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
