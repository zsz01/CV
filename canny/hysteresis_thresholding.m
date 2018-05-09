function [linked_edge] = hysteresis_thresholding(threshold_low, threshold_high, edge, angle)
%  ˫��ֵ�ı߽����ӷ�

% threshold_low: �ͷ�ֵ
% threshold_high: �߷�ֵ
% edge: NMS����ݶ�ǿ�Ⱦ���
% linked_edge: ˫��ֵ���ƺ��01����1����Ϊ��Ե��

    [m, n] = size(edge);
    linked_edge = zeros(m, n);
    vis = zeros(m,n);% �ж��Ƿ�����չ�õ�
    stack = zeros(m*n,2);% ջ��������չ�ı�Ե��ѹ��
    top = 1;%ָʾջ����ջ��Ϊ��
    angle = abs(angle - pi/2);
    
    for x = 1+1:m-1
        for y = 1+1:n-1
            % ���ڵͷ�ֵ
            if edge(x,y) < threshold_low
                continue;
            end
            
            % ���ڸ߷�ֵ
            if edge(x,y) > threshold_high
                linked_edge(x,y) = 1;
                stack(top,1) = x;
                stack(top,2) = y;
                top = top + 1;
                continue;
            end
        end
    end
    
    while top ~= 1
        top = top - 1;
        cur_x = stack(top,1);
        cur_y = stack(top,2);
        vis(cur_x,cur_y) = 1;
        % ��
        if angle(cur_x,cur_y) == 0
            if edge(cur_x,cur_y-1) > threshold_low && vis(cur_x, cur_y-1) == 0  
                linked_edge(cur_x,cur_y-1) = 1;
                stack(top,1) = cur_x;
                stack(top,2) = cur_y-1;
                top = top + 1;
            end
        end
        
        if angle(cur_x,cur_y) == 0
            if edge(cur_x,cur_y+1) > threshold_low && vis(cur_x, cur_y+1) == 0  
                linked_edge(cur_x,cur_y+1) = 1;
                stack(top,1) = cur_x;
                stack(top,2) = cur_y+1;
                top = top + 1;
            end
        end
        
        
        % ��
        if angle(cur_x,cur_y) == pi/2
            if edge(cur_x-1,cur_y) > threshold_low && vis(cur_x-1, cur_y) == 0  
                linked_edge(cur_x-1,cur_y) = 1;
                stack(top,1) = cur_x-1;
                stack(top,2) = cur_y;
                top = top + 1;
            end
        end
        
        if angle(cur_x,cur_y) == pi/2
            if edge(cur_x+1,cur_y) > threshold_low && vis(cur_x+1, cur_y) == 0  
                linked_edge(cur_x+1,cur_y) = 1;
                stack(top,1) = cur_x+1;
                stack(top,2) = cur_y;
                top = top + 1;
            end
        end
        
        % ����
        if angle(cur_x,cur_y) == pi/4
            if edge(cur_x+1,cur_y-1) > threshold_low && vis(cur_x+1, cur_y-1) == 0  
                linked_edge(cur_x+1,cur_y-1) = 1;
                stack(top,1) = cur_x+1;
                stack(top,2) = cur_y-1;
                top = top + 1;
            end
        end
        
        if angle(cur_x,cur_y) == pi/4
            if edge(cur_x-1,cur_y+1) > threshold_low && vis(cur_x-1, cur_y+1) == 0  
                linked_edge(cur_x-1,cur_y+1) = 1;
                stack(top,1) = cur_x-1;
                stack(top,2) = cur_y+1;
                top = top + 1;
            end
        end
        % ����
        if angle(cur_x,cur_y) == 3*pi/4
            if edge(cur_x-1,cur_y-1) > threshold_low && vis(cur_x-1, cur_y-1) == 0  
                linked_edge(cur_x-1,cur_y-1) = 1;
                stack(top,1) = cur_x-1;
                stack(top,2) = cur_y-1;
                top = top + 1;
            end
        end
        
        if angle(cur_x,cur_y) == 3*pi/4
            if edge(cur_x+1,cur_y+1) > threshold_low && vis(cur_x+1, cur_y+1) == 0  
                linked_edge(cur_x+1,cur_y+1) = 1;
                stack(top,1) = cur_x+1;
                stack(top,2) = cur_y+1;
                top = top + 1;
            end
        end
        
    end
    
    
end



