function data = redistribute(data, ds)
L=length(data(:,1));
dataSeg=cell(1,ceil(L/4));
dataSeg{1}=densify(data(4*1-3:1:4*1+3,:),ds/10,1,1);
for ii=2:1:floor(L/4)-1
dataSeg{ii}=densify(data(4*ii-3:1:4*ii+3,:),ds/10,1,1);
dataSeg{ii}=dataSeg{ii}(2:1:length(dataSeg{ii}),:);
end;
ii=ii+1;
dataSeg{ii}=densify(data(4*ii-3:1:L,:),ds/10,1,1);
dataSeg{ii}=dataSeg{ii}(2:1:length(dataSeg{ii}),:);
dataNew0=cat(1,dataSeg{:});
dataNew=dataNew0(1:10:length(dataNew0),:);
if mod(length(dataNew0),10)~=1
   dataNew(end,:)=data(L-1,:);
   lastSecond=length(dataNew0)-10;
   dataNew(end-1,:)=dataNew0(lastSecond,:);
else
    dataNew(end,:)=data(L-1,:);
end;
data=dataNew;