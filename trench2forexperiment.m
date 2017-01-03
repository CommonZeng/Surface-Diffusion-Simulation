function [ ] = trench2forexperiment(width, gap, depth, fileOpenNum, tMax)

pitch=width+gap;
radius=width/2;

Diffco=2e6;
q=1.602e-19;
surfacetension=6.24e18*q/1e9;
NAv=6.02e23;
Omega=12e-6*1e27/NAv;
Xs=4/0.54^2;
kT=0.026;
b=Diffco*surfacetension*Omega^2*Xs/kT;
b=1e6;
ds=5;

foldername=['C:\Documents and Settings\eeuser\My Documents\MATLAB\Surface diffustion\data for experiment\trenchW' num2str(width) 'G' ...
    num2str(gap) 'D' num2str(depth) 'G' num2str(ds)];
mkdir(foldername);
cd(foldername);
if fileOpenNum==0
    data0=dataGen(pitch,radius,depth,ds);
    data=cell(1);
    data{1}=data0;
    t0=0;
    fileNum = 0;
else
    fileOpenName=['[' num2str(fileOpenNum) ']trenchW' num2str(width) 'G' num2str(gap) 'D' num2str(depth) '.mat'];
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
caption=['Width=' num2str(width) 'Gap=' num2str(gap) ' Depth=' num2str(depth) ...
    ' ds=' num2str(max(ds)) ' b=' num2str(b)];
annotation(gcf,'textbox','String',{caption},'FontSize',8,'Position',[0.32 0.95 0.6 0.05],'edgecolor',get(gcf,'color'));
set(gcf,'Visible','off');
picFileName=['trenchW' num2str(width) 'G' num2str(gap) 'D' num2str(depth) 't=' num2str(round(t0)) 'to' num2str(tMax) '.png'];
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
        filename=['[' num2str(fileNum) ']trenchW' num2str(width) 'G' num2str(gap) 'D' num2str(depth) '.mat'];
        save(filename,'data','tNow');
    end;
end;
hold off;
close all;