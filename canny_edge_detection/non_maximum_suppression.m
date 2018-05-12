function [edge] = non_maximum_suppression(magnitude, angle, edge)
% 非极大值抑制，保留梯度方向强度的极大值点，将模糊的边界变得清晰

% magnitude: 梯度强度矩阵
% angle: 梯度方向矩阵
% edge: 沿梯度方向的局部最大值设为1，其他点被抑制为0，二值矩阵

if nargin < 3
    [m, n] = size(magnitude);
    edge = zeros(m, n);
end

    [m, n] = size(edge);
    for y = 1+1:m-1
        for x = 1+1:n-1
            % 横
            if angle(y,x) == 0
                if magnitude(y,x) > max(magnitude(y,x-1), magnitude(y,x+1))
                    edge(y,x) = magnitude(y,x);
                end
            end

            % 竖
            if angle(y,x) == pi/2
                if magnitude(y,x) > max(magnitude(y-1,x), magnitude(y+1,x))
                    edge(y,x) = magnitude(y,x);
                end
            end

            % 右上
            if angle(y,x) == pi/4
                if magnitude(y,x) > max(magnitude(y-1,x+1), magnitude(y+1,x-1))
                    edge(y,x) = magnitude(y,x);
                end
            end

            % 左上
            if angle(y,x) == 3*pi/4
                if magnitude(y,x) > max(magnitude(y+1,x+1), magnitude(y-1,x-1))
                    edge(y,x) = magnitude(y,x);
                end
            end
        end
    end
end