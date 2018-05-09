function imBlend = recoverLaplacian(Laplacians,w)
    nlevel = max(size(Laplacians));
    
    laps = cell(nlevel,2); 
    for i = 1 : nlevel
        laps{i,2} = cell2mat(Laplacians(i));
    end
    
    
    laps{end,1} = laps{end,2};
    for i = nlevel-1 : -1 : 1
        
        temp = expand(laps{i+1,1},w);
        % 使expand生成的矩阵与对应的高斯矩阵一样大
        expSize = size(temp); 
        orgSize = size(laps{i,2}); 
        if(expSize(1) < orgSize(1))
            temp = vertcat(temp, temp(end,:,:));
        end
        if(expSize(2) < orgSize(2))
            temp =  horzcat(temp, temp(:,end,:));
        end
        laps{i,1} = laps{i,2} + temp; 
    end
    
    imBlend = laps{1,1};
end