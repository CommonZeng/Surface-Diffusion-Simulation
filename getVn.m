function [dsm, normal, v, dt]=getVn(data, b)
R=[0 -1
    1  0];
N=length(data);
dsm=ones(N,1);
dsf=dsm;
dsb=dsm;
tangent=zeros(N,2);
normal=zeros(N,2);
curv=zeros(N,1);
curvGrad=zeros(N,1);
v=zeros(N,1);

for ii=2:1:N-1
    dsf(ii)=norm(data(ii+1,:)-data(ii,:));
    dsb(ii)=norm(data(ii,:)-data(ii-1,:));
    dsm(ii)=(dsf(ii)+dsb(ii))/2;
end;
for ii=2:1:N-1
    tangent(ii,:)=((data(ii+1,:)-data(ii,:))/dsf(ii)+(data(ii,:)-data(ii-1,:))/dsb(ii))/2;
    tangent(ii,:)=tangent(ii,:)/norm(tangent(ii,:));
end;
for ii=2:1:N-1
    normal(ii,:)=(R*tangent(ii,:)')';
    normal(ii,:)=normal(ii,:)/norm(normal(ii,:));
end;
for ii=3:1:N-2
    curv(ii)=(-norm(tangent(ii+1,:)-tangent(ii,:))/dsf(ii)*sign(dot(tangent(ii+1,:),normal(ii,:)))- ...
        norm(tangent(ii,:)-tangent(ii-1,:))/dsb(ii)*sign(dot(tangent(ii,:),normal(ii-1,:))))/2;
end;
curv(3)=curv(7);
curv(4)=curv(6);
curv(N-2)=curv(N-6);
curv(N-3)=curv(N-5);
for ii=4:1:N-3
    curvGrad(ii)=((curv(ii+1)-curv(ii))/dsf(ii)+(curv(ii)-curv(ii-1))/dsb(ii))/2;
end;
curvGrad(5)=(curv(6)-curv(5))/dsf(5);
curvGrad(N-4)=-(curv(N-3)-curv(N-4))/dsf(N-4);
for ii=5:1:N-4
    v(ii)=b*((curvGrad(ii+1)-curvGrad(ii))/dsf(ii)+(curvGrad(ii)-curvGrad(ii-1))/dsb(ii))/2;
end;
dt=1/(2 * max(b(:)) * min(dsm(5:1:N-4)) .^ -4);