pitch=100;
ds=5;
radius=9:1:41;
depth=1200:-100:400;

for ii=1:1:length(depth)
    for jj=1:1:length(radius)
        
        foldername=['C:\Documents and Settings\eeuser\My Documents\MATLAB\Surface diffustion\data\trenchP' num2str(pitch) 'R' ...
            num2str(radius(jj)) 'D' num2str(depth(ii)) 'G' num2str(ds)];
        cd(foldername);
        fileOpenNum=100;
        fileOpenName=['trenchP' num2str(pitch) 'R' num2str(radius(jj)) 'D' num2str(depth(ii)) 't=' num2str(25*fileOpenNum) 'to' num2str(25*(fileOpenNum+1)) '.png'];
        while(fopen(fileOpenName)==-1)
            fileOpenNum=fileOpenNum-1;
            close('all');
            fileOpenName=['trenchP' num2str(pitch) 'R' num2str(radius(jj)) 'D' num2str(depth(ii)) 't=' num2str(25*fileOpenNum) 'to' num2str(25*(fileOpenNum+1)) '.png'];
        end;
        
        copyfile(fileOpenName,'C:\Documents and Settings\eeuser\My Documents\MATLAB\Surface diffustion\data\phase\');
    end;
end;


