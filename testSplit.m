function [data, happen]=testSplit(data, pitch, ds)
L=length(data);
dataNew=data;
newNum=0;
happen=0;
for mm=1:1:L

        leftBound=7;
        rightBound=length(data{mm})-6;
 
    
    for ii=leftBound:1:rightBound
        if data{mm}(ii,1)<0
            happen=1;
            jj=ii;
            while(data{mm}(jj,1)<=0)
                jj=jj+1;
            end;
            jj=jj-1;
            newNum=newNum+1;
            dataNew{L+newNum}=dataNew{mm}(jj:1:end-4,:);
            
            dataDense1=densify(data{mm}(ii-3:1:ii+1,:),ds/100,1,1);
            [C I]=min(abs(dataDense1(:,1)));
            dataNew{mm}(ii,1)=0;
            dataNew{mm}(ii,2)=dataDense1(I,2);
            dataNew{mm}=dataNew{mm}(5:1:ii,:);
            dataNew{mm}=addGhost(dataNew{mm},0);
            
            dataDense2=densify(data{mm}(jj-1:1:jj+3,:),ds/100,1,1);
            [C I]=min(abs(dataDense2(:,1)));
            dataNew{L+newNum}(1,1)=0;
            dataNew{L+newNum}(1,2)=dataDense2(I,2);
            dataNew{L+newNum}=addGhost(dataNew{L+newNum},0);
            break;
        end;
        
        if data{mm}(ii,1)>pitch/2
            happen=1;
            jj=ii;
            while(data{mm}(jj,1)>=pitch/2)
                jj=jj+1;
            end;
            jj=jj-1;
            newNum=newNum+1;
            dataNew{L+newNum}=dataNew{mm}(jj:1:end-4,:);
            
            dataDense1=densify(data{mm}(ii-3:1:ii+1,:),ds/100,1,1);
            [C I]=min(abs(dataDense1(:,1)-pitch/2));
            dataNew{mm}(ii,1)=pitch/2;
            dataNew{mm}(ii,2)=dataDense1(I,2);
            dataNew{mm}=dataNew{mm}(5:1:ii,:);
            dataNew{mm}=addGhost(dataNew{mm},0);
            
            dataDense2=densify(data{mm}(jj-1:1:jj+3,:),ds/100,1,1);
            [C I]=min(abs(dataDense2(:,1)-pitch/2));
            dataNew{L+newNum}(1,1)=pitch/2;
            dataNew{L+newNum}(1,2)=dataDense2(I,2);
            dataNew{L+newNum}=addGhost(dataNew{L+newNum},0);
            break;
        end;
    end;
end;
data=dataNew;