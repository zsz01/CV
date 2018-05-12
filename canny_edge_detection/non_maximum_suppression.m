function [edge] = non_maximum_suppression(magnitude, angle, edge)
% �Ǽ���ֵ���ƣ������ݶȷ���ǿ�ȵļ���ֵ�㣬��ģ���ı߽�������

% magnitude: �ݶ�ǿ�Ⱦ���
% angle: �ݶȷ������
% edge: ���ݶȷ���ľֲ����ֵ��Ϊ1�������㱻����Ϊ0����ֵ����

if nargin < 3
    [m, n] = size(magnitude);
    edge = zeros(m, n);
end

    [m, n] = size(edge);
    for y = 1+1:m-1
        for x = 1+1:n-1
            % ��
            if angle(y,x) == 0
                if magnitude(y,x) > max(magnitude(y,x-1), magnitude(y,x+1))
                    edge(y,x) = magnitude(y,x);
                end
            end

            % ��
            if angle(y,x) == pi/2
                if magnitude(y,x) > max(magnitude(y-1,x), magnitude(y+1,x))
                    edge(y,x) = magnitude(y,x);
                end
            end

            % ����
            if angle(y,x) == pi/4
                if magnitude(y,x) > max(magnitude(y-1,x+1), magnitude(y+1,x-1))
                    edge(y,x) = magnitude(y,x);
                end
            end

            % ����
            if angle(y,x) == 3*pi/4
                if magnitude(y,x) > max(magnitude(y+1,x+1), magnitude(y-1,x-1))
                    edge(y,x) = magnitude(y,x);
                end
            end
        end
    end
end