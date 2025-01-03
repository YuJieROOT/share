function showHSIResult(Re_hsi,Ohsi,noise,div,methodname,enList,band2show,bandnum)
%% Use to show the denoised HSI results

numLine = ceil((length(enList)+2)/6);
% figure('units','normalized','position',[0.05,0.482-0.29*3/2,0.9,0.29*3],'name','video');
%% UI
close all;

figure('units','normalized','position',[0.05,0.482-0.29*numLine/2,0.9,0.29*numLine],'name','HSI');
sld = uicontrol('Style', 'slider',...
    'Min',1,'Max',bandnum,'Value',band2show,...
    'Position', [645 20 500 20],...
    'Callback', @TheFram);
showShow(band2show)

    function showShow(band2show)
        txt = uicontrol('Style','text',...
            'Position',[645 45 500 20],...
            'String',['Showing the ', num2str(band2show) ,'th band']);
        set(txt,'Fontsize',13)
        numLine = ceil((length(enList)+1)/6);

        subplot(numLine,6,1); imshow(Ohsi(:,:,band2show)); 
        subplot(numLine,6,2); imshow(noise(:,:,band2show));
        for i = 1:length(enList)
            subplot(numLine,6,i+2);
            imshow(Re_hsi{enList(i)}(:,:,band2show));
        end
        for j = 1:length(enList)
            subplot(numLine,6,i+j+2);
            imshow(div{enList(j)}(:,:,band2show));
        end
    end


    function TheFram(source,callbackdata)
        band2show =  round(source.Value);
        showShow(band2show)
    end
end