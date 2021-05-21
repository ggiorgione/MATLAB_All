k = 1;

if k == 1
    
    colormap(end+1,:) = [0 0 0];
    cdata(cdata(:,:) == 0) = size(colormap,1);
    arrow_pic = zeros(256,256,3);
    
    
    for j = 1:3
        for i = 1:256
            arrow_pic(:,i,j) = colormap(cdata(:,i),j).*255;
            
        end
    end

    
    figure(3)
    
    arrow_pic = uint8(arrow_pic);
    imagesc(arrow_pic)
    save('arrow_pic','arrow_pic')
    
    
elseif k == 2
    pdata = cdata;
    datasetgood = sum(cdata == 255,3) == 3;
    
    %  for i = 1:256
    %      if i > 55 && i < 180
    %          datasetgood(i,:) = 0;
    %      end
    %  end
    
    
    for j = 1:3
        for i = 1:256
            pdata(datasetgood(:,i),i,j) = 0;
        end
    end
    
    fill_plot = pdata;
    chart_pic = uint8(chart_pic);
    imagesc(fill_plot)
    save('fill_plot','fill_plot')
end

