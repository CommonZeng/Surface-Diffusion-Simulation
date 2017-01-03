clear all;
N=20;
dx=1/N;
X=dx:dx:N*dx;
Y=zeros(N,1);
dYdX=zeros(N,1);
d2YdX=zeros(N,1);
K=zeros(N,1);
dKds=zeros(N,1);
d2Kds=zeros(N,1);
v=zeros(N,1);
f=1;
for k=1:1:1
    for n=1:1:N
        Y(n)=Y(n)+1/(2*k-1)*sin(2*pi*(2*k-1)*f*X(n));
        % Y(n)=X(n)^2+sin(X(n)*4);
    end;
end;
%     [X,Y]=interpcurve(X,Y);
%    N=length(X);
figure;
plot(X,Y,'x');
hold on;
for t=1:1:1
    for n=1:1:N-1
        dYdX(n)=(Y(n+1)-Y(n))/(X(n+1)-X(n));
    end;
    dYdX(N)=dYdX(N-1);
    for n=1:1:N-1
        d2YdX(n)=(dYdX(n+1)-dYdX(n))/(X(n+1)-X(n));
        K(n)=d2YdX(n)/((1+(dYdX(n)^2))^1.5);
    end;
    d2YdX(N-1)=d2YdX(N-2);
    d2YdX(N)=d2YdX(N-1);
    K(N-1)=K(N-2);
    K(N)=K(N-1);
    for n=1:1:N-3
        dKds(n)=(K(n+1)-K(n))/((X(n+1)-X(n))^2+(Y(n+1)-Y(n))^2)^0.5;
    end;
    dKds(N-2)=dKds(N-3);
    dKds(N-1)=dKds(N-2);
    dKds(N)=dKds(N-1);
    for n=1:1:N-1
        d2Kds(n)=(dKds(n+1)-dKds(n))/((X(n+1)-X(n))^2+(Y(n+1)-Y(n))^2)^0.5;
        
    end;
    d2Kds(N-3)=d2Kds(N-4);
    d2Kds(N-2)=d2Kds(N-3);
    d2Kds(N-1)=d2Kds(N-2);
    d2Kds(N)=d2Kds(N-1);
    for n=1:1:N
        v(n)=1E-7*abs(d2Kds(n))
      
       if dYdX(n)~=0
      X(n)=X(n)+sign(dYdX(n)*d2YdX(n))*v(n)*cos(pi/2-abs(atan(dYdX(n))));
            Y(n)=Y(n)-sign(dYdX(n))*sign(dYdX(n)*d2YdX(n))*v(n)*sin(pi/2-abs(atan(dYdX(n))));
       else
           if d2YdX(n)>0
               Y(n)=Y(n)-v(n);
           else Y(n)=Y(n)+v(n);
           end;
       end;

    end;
%    [X,Y]=interpcurve(X,Y);
% N=length(X);

    plot(X,Y,'r.');
    hold on;
    %need to redistribute X and Y with n
end;

plot(X,Y,'r');

