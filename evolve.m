function [ data, tNow, happen ]=evolve(data, tNow, b, ds, pitch)
L=length(data);
dsm=cell(L,1);
normal=dsm;
v=dsm;
N=dsm;
dtSub=zeros(L,1);

for mm=1:1:L
    [dsm{mm}, normal{mm}, v{mm}, dtSub(mm)]=getVn(data{mm}, b);
    N{mm}=length(data{mm});
end;
dt=min(dtSub);
for mm=1:1:L
    for ii=5:1:N{mm}-4
        data{mm}(ii,:)=data{mm}(ii,:)+v{mm}(ii)*dt*normal{mm}(ii,:);
    end;
end;
tNow=tNow+dt;

for mm=1:1:length(data)
    if min(dsm{mm}(5:1:end-4))<0.5*ds||max(dsm{mm}(5:1:end-4))>2*ds
        data{mm}=redistribute(data{mm}(4:1:N{mm}-3,:),ds);
        data{mm}=addGhost(data{mm},0);
        fprintf('\tReinitialized at t=%g\n', tNow);
    else
        data{mm}=addGhost(data{mm},1);
    end;
end;
[data, happen]=testSplit(data, pitch, ds);
