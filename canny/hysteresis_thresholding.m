function [linked_edge] = hysteresis_thresholding(threshold_low, threshold_high, edge, angle)
%  双阈值的边界链接法

% threshold_low: 低阀值
% threshold_high: 高阀值
% edge: NMS后的梯度强度矩阵
% linked_edge: 双阈值限制后的01矩阵，1代表为边缘点

    [m, n] = size(edge);
    linked_edge = zeros(m, n);
    vis = zeros(m,n);% 判断是否已扩展该点
    stack = zeros(m*n,2);% 栈，将待扩展的边缘点压入
    top = 1;%指示栈顶，栈顶为空
    angle = abs(angle - pi/2);
    
    for x = 1+1:m-1
        for y = 1+1:n-1
            % 低于低阀值
            if edge(x,y) < threshold_low
                continue;
            end
            
            % 高于高阀值
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
        % 横
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
        
        
        % 竖
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
        
        % 右上
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
        % 左上
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



