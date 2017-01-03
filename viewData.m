function []=viewData(data)
for mm=1:1:length(data)
    plot(data{mm}(:,1),data{mm}(:,2),'.');
    hold on;
    grid on;
end;