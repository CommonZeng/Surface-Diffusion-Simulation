function data = dataGen(pitch, radius, depth, ds)
length=pitch/2+depth;
N=length/ds+1;
data=zeros(N,2);
for ii=1:1:radius/ds
    data(ii,:)=[ds*(ii-1),0];
end;
for jj=ii+1:1:ii+1+depth/ds
    data(jj,:)=[radius,ds*(jj-ii-1)];
end;
for kk=jj+1:1:N
    data(kk,:)=[radius+ds*(kk-jj),depth];
end;
data=[data(5:-1:2,:); data; data(N-1:-1:N-4,:)];
N=N+8;
data(1,1)=-4*ds;
data(2,1)=-3*ds;
data(3,1)=-2*ds;
data(4,1)=-1*ds;
data(N-3,1)=pitch-data(N-5,1);
data(N-2,1)=pitch-data(N-6,1);
data(N-1,1)=pitch-data(N-7,1);
data(N,1)=pitch-data(N-8,1);
