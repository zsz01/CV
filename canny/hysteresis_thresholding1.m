function [linked_edge] = hysteresis_thresholding1(threshold_low, threshold_high, edge, linked_edge)
%  ˫��ֵ�ı߽����ӷ�

% threshold_low: �ͷ�ֵ
% threshold_high: �߷�ֵ
% edge: NMS����ݶ�ǿ�Ⱦ���
% linked_edge: ˫��ֵ���ƺ��01����1����Ϊ��Ե��

if nargin < 4
    [m, n] = size(edge);
    linked_edge = zeros(m, n);
end

    [m, n] = size(linked_edge);
    for y = 1+1:m-1
        for x = 1+1:n-1
            
            % ���ڵͷ�ֵ
            if edge(y,x) < threshold_low
                continue;
            end
            
            % ���ڸ߷�ֵ
            if edge(y,x) > threshold_high
                linked_edge(y,x) = 1;
                continue;
            end
            
            % ���ڵͷ�ֵ��߷�ֵ֮���
            if (edge(y,x) <= threshold_high) && (edge(y,x) >= threshold_low)
                % ���8�����Ƿ���ǿ��Ե��
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