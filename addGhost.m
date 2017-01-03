function data = addGhost(data, exist)
N=length(data);
if exist==0
data=[data(5:-1:2,:); data; data(N-1:-1:N-4,:)];
N=N+8;
end;
data(1,:)=[2*data(5,1)-data(9,1),data(9,2)];
data(2,:)=[2*data(5,1)-data(8,1),data(8,2)];
data(3,:)=[2*data(5,1)-data(7,1),data(7,2)];
data(4,:)=[2*data(5,1)-data(6,1),data(6,2)];

data(N-3,:)=[2*data(N-4,1)-data(N-5,1),data(N-5,2)];
data(N-2,:)=[2*data(N-4,1)-data(N-6,1),data(N-6,2)];
data(N-1,:)=[2*data(N-4,1)-data(N-7,1),data(N-7,2)];
data(N,:)=[2*data(N-4,1)-data(N-8,1),data(N-8,2)];
