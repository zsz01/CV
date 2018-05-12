function [linked_edge] = hysteresis_thresholding1(threshold_low, threshold_high, edge, linked_edge)
%  双阈值的边界链接法

% threshold_low: 低阀值
% threshold_high: 高阀值
% edge: NMS后的梯度强度矩阵
% linked_edge: 双阈值限制后的01矩阵，1代表为边缘点

if nargin < 4
    [m, n] = size(edge);
    linked_edge = zeros(m, n);
end

    [m, n] = size(linked_edge);
    for y = 1+1:m-1
        for x = 1+1:n-1
            
            % 低于低阀值
            if edge(y,x) < threshold_low
                continue;
            end
            
            % 高于高阀值
            if edge(y,x) > threshold_high
                linked_edge(y,x) = 1;
                continue;
            end
            
            % 介于低阀值与高阀值之间的
            if (edge(y,x) <= threshold_high) && (edge(y,x) >= threshold_low)
                % 检查8领域是否有强边缘点
                temp =[ edge(y-1,x-1),  edge(y-1,x),    edge(y-1,x+1);
                        edge(y,x-1),    edge(y,x),      edge(y,x+1);
                        edge(y+1,x-1),  edge(y+1,x),    edge(y+1,x+1)];
                tempMax = max(max(temp));
                if tempMax > threshold_high
                    linked_edge(y,x) = 1;
                end
            end
        end
    end
end