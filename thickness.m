pitch=100;
ds=5;
radius=9:1:41;
depth=1200:-100:400;
recess=zeros(length(depth),length(radius));
membrane=recess;
cavity=recess;
for ii=1:1:length(depth)
    for jj=1:1:length(radius)
        
        foldername=['C:\Documents and Settings\eeuser\My Documents\MATLAB\Surface diffustion\data\trenchP' num2str(pitch) 'R' ...
            num2str(radius(jj)) 'D' num2str(depth(ii)) 'G' num2str(ds)];
        cd(foldername);
        fileOpenNum=1000;
        fileOpenName=['[' num2str(fileOpenNum) ']trenchP' num2str(pitch) 'R' num2str(radius(jj)) 'D' num2str(depth(ii)) '.mat'];
        while(fopen(fileOpenName)==-1)
            fileOpenNum=fileOpenNum-1;
            close('all');
            fileOpenName=['[' num2str(fileOpenNum) ']trenchP' num2str(pitch) 'R' num2str(radius(jj)) 'D' num2str(depth(ii)) '.mat'];
        end;
        
        load(fileOpenName, 'data');
        close('all');
        L=length(data);
        if L==3
            height=zeros(L,1);
            for mm=1:1:L
                height(mm)=mean(data{mm}(:,2));
            end;
            height=sort(height,'descend');
            recess(ii,jj)=depth(ii)-height(1);
            membrane(ii,jj)=height(1)-height(2);
            cavity(ii,jj)=height(2)-height(3);
        end;
    end;
end;
xlswrite('C:\Documents and Settings\eeuser\My Documents\MATLAB\Surface diffustion\thickness1.xls',recess,1);
xlswrite('C:\Documents and Settings\eeuser\My Documents\MATLAB\Surface diffustion\thickness1.xls',membrane,2);
xlswrite('C:\Documents and Settings\eeuser\My Documents\MATLAB\Surface diffustion\thickness1.xls',cavity,3);
