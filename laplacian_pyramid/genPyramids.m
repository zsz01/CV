%% ����������˹�������͸�˹������
function laps = genPyramids(img, nlvls)
    %Ĭ�����4�������
    if(nargin <= 1)
        nlvls = 4;
    end
    w = [1/8 1/4 1/4 1/4 1/8];
    
    %laps{i,1}���˹������
    %laps{i,2}��������˹������
    laps = cell(nlvls,2); 
    laps{1,1} = double(img);
    for i = 2 : nlvls
        laps{i,1} = reduce(laps{i-1,1},w);
    end
    laps{end,2} = laps{end,1};
    for i = nlvls-1 : -1 : 1
        temp = expand(laps{i+1,1},w);
        expSize = size(temp);
        orgSize = size(laps{i,1});
        %ʹͼ���Сһ��
        if(expSize(1) < orgSize(1))
            temp = vertcat(temp, temp(end,:,:));
        end
        if(expSize(2) < orgSize(2))
           temp =  horzcat(temp, temp(:,end,:));
        end
        %����������˹������
        laps{i,2} = laps{i,1} - temp;
    end