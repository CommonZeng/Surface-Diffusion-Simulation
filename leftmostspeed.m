pitch=100;
ds=5;
radius=20;
depth=300;
N=90;
leftmostX=1000*ones(1,N);
leftmostY=leftmostX;
T=1:1:N;
foldername=['C:\Documents and Settings\eeuser\My Documents\MATLAB\Surface diffustion\data\trenchP' num2str(pitch) 'R' ...
    num2str(radius) 'D' num2str(depth) 'G' num2str(ds)];
cd(foldername);
fileOpenNum=1;
fileOpenName=['[' num2str(fileOpenNum) ']trenchP' num2str(pitch) 'R' num2str(radius) 'D' num2str(depth) '.mat'];
while(fileOpenNum<=N)
  fopen(fileOpenName);
    load(fileOpenName, 'data');
    for ii=1:1:length(data{1})
    if leftmostX(fileOpenNum)>data{1}(ii,1)&&data{1}(ii,2)>150
        leftmostX(fileOpenNum)=data{1}(ii,1);
        leftmostY(fileOpenNum)=data{1}(ii,2);
    end;
    end;
      fileOpenNum=fileOpenNum+1;
    close('all');
    fileOpenName=['[' num2str(fileOpenNum) ']trenchP' num2str(pitch) 'R' num2str(radius) 'D' num2str(depth) '.mat'];
end;
figure;
plot(T,leftmostX,'x');
grid;
title('Movement of the leftmost point');
ylabel('X coordinate of the leftmost point / um');
xlabel('Time / s');
figure;
plot(T,leftmostY,'.');
grid;
title('Movement of the leftmost point');
ylabel('Y coordinate of the leftmost point / um');
xlabel('Time / s');
hold off;
