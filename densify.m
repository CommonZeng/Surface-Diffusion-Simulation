function data = densify(data, ds, ghostH, ghostT)
X=data(:,1);
Y=data(:,2);
Xend=X(end-ghostT);
Yend=Y(end-ghostT);
L=length(X);
T=(1:1:L)';
PX=polyfit(T,X,L-1);
PY=polyfit(T,Y,L-1);
X=X(ghostH+1:1:end);
Y=Y(ghostH+1:1:end);
dt=ds/20;
t=1;
ii=1;
while(t<L-ghostT-ghostH)
    ii=ii+1;
    X(ii)=X(ii-1);
    Y(ii)=Y(ii-1);
    while (X(ii)-X(ii-1))^2+(Y(ii)-Y(ii-1))^2<(ds)^2
        t=t+dt;
        X(ii)=polyval(PX,t+ghostH);
        Y(ii)=polyval(PY,t+ghostH);
    end;
end;
if t>L-ghostT-ghostH
    X(ii-1)=Xend;
    Y(ii-1)=Yend;
    X(ii)=[];
    Y(ii)=[];
elseif t==L-ghostT-ghostH
    X(ii)=Xend;
    Y(ii)=Yend;
    X(ii+1)=[];
    Y(ii+1)=[];
end;
data=[X Y];