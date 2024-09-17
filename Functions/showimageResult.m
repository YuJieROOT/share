function showimageResult(TCTV,GTCTV,Ohsi,noise,methodname,enList,band2show,bandnum)
%% Use to show the denoised HSI results

numLine = ceil((length(enList)+2)/4);
% figure('units','normalized','position',[0.05,0.482-0.29*3/2,0.9,0.29*3],'name','video');
%% UI
close all;

figure('units','normalized','position',[0.05,0.482-0.29*numLine/2,0.9,0.29*numLine],'name','Color_image');
% figure;
sld = uicontrol('Style', 'slider',...
    'Min',1,'Max',bandnum,'Value',band2show,...
    'Position', [645 20 500 20],...
    'Callback', @TheFram);
showShow(band2show)

    function showShow(band2show)
        txt = uicontrol('Style','text',...
            'Position',[645 45 500 20],...
            'String',['Showing the ', num2str(band2show) ,'th image']);
        set(txt,'Fontsize',13)
        numLine = ceil((length(enList)+1)/4);

        subplot(numLine,4,1); imshow(Ohsi{band2show}); 
        subplot(numLine,4,2); imshow(noise{band2show}); 
        subplot(numLine,4,3); imshow(TCTV{band2show}); 
        subplot(numLine,4,4); imshow(GTCTV{band2show}); 
    end


    function TheFram(source,callbackdata)
        band2show =  round(source.Value);
        showShow(band2show)
    end
end