function [ ] = trench2(radius, depth, fileOpenNum, tMax)
pitch=100;
ds=5;
b=100000;

foldername=['C:\Documents and Settings\eeuser\My Documents\MATLAB\Surface diffustion\data\trenchP' num2str(pitch) 'R' ...
    num2str(radius) 'D' num2str(depth) 'G' num2str(ds)];
mkdir(foldername);
cd(foldername);
if fileOpenNum==0
    data0=dataGen(pitch,radius,depth,1);
    data=cell(1);
    data{1}=data0;
    t0=0;
    fileNum = 0;
else
    fileOpenName=['[' num2str(fileOpenNum) ']trenchP' num2str(pitch) 'R' num2str(radius) 'D' num2str(depth) '.mat'];
    load(fileOpenName, '*');
    t0=tNow;
    fileNum = fileOpenNum;
end;
plotSteps = 25;
tPlot = (tMax - round(t0)) / plotSteps;
tFile = tPlot;
small = 100 * eps;
% logFileName=[num2str(radius) 'D' num2str(depth) 't=' num2str(round(t0)) 'to' num2str(tMax) '.txt'];

fSurface = figure('visible','off');
caption=['Pitch=' num2str(pitch) 'Radius=' num2str(radius) ' Depth=' num2str(depth) ...
    ' ds=' num2str(max(ds)) ' b=' num2str(b)];
annotation(gcf,'textbox','String',{caption},'FontSize',8,'Position',[0.32 0.95 0.6 0.05],'edgecolor',get(gcf,'color'));
set(gcf,'Visible','off');
picFileName=['trenchP' num2str(pitch) 'R' num2str(radius) 'D' num2str(depth) 't=' num2str(round(t0)) 'to' num2str(tMax) '.png'];
rows = ceil(sqrt(plotSteps));
cols = ceil(plotSteps / rows);
plotNum = 0;
tNow = t0;
% startTime = cputime;

while(tMax - tNow > 0)

    
    [data, tNow, happen]=evolve(data, tNow, b, ds, pitch);

    if tNow-round(t0)-tPlot*(plotNum+1)>=0 || tMax - tNow <= 0
        h=figure(fSurface);
        plotNum = plotNum + 1;
        subplot(rows, cols, plotNum);
        set(gcf,'Visible','off');
        for mm=1:1:length(data)
            plot(data{mm}(:,1),data{mm}(:,2));
            hold on;
        end;
        title(['t=',num2str(round(tNow))]);
        axis([0, pitch/2, -depth*0.1, depth*1.1]);
        saveas(h,picFileName);
    end;
    if tNow-round(t0)-tFile*(fileNum-fileOpenNum+1)>=0 || tMax - tNow <= 0
        fileNum=fileNum+1;
        filename=['[' num2str(fileNum) ']trenchP' num2str(pitch) 'R' num2str(radius) 'D' num2str(depth) '.mat'];
        save(filename,'data','tNow');
    end;
end;
hold off;
close all;