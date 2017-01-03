%%This fuction accepts a sequence of points on a curve and returns a
%%interpolated sequence. The distance between adjacent points on this curve
%%is the minimum distance of the original curve.
%%[X,Y] stores the old coordinates of the sequence of points.
%%[Xnew,Ynew] is the interpolated sequence of points.

function [Xnew,Ynew]=interpcurve(X,Y)
vectorlen=length(X);%% Numuber of points.
curvelen=0;
for i=1:1:vectorlen-1
    curvelen=curvelen+sqrt((X(i+1)-X(i))^2+(Y(i+1)-Y(i))^2);
end;

%%finding the minimum distance between two points.
mindistance=curvelen;
for i=1:1:vectorlen-1
    if mindistance>sqrt((X(i+1)-X(i))^2+(Y(i+1)-Y(i))^2)
        mindistance=sqrt((X(i+1)-X(i))^2+(Y(i+1)-Y(i))^2);
    end;
end;
%%finding the minimum distance between two points.

num=1:1:vectorlen;
newnum=1:1*mindistance:ceil(curvelen/1/mindistance);
Xnew=interp1(num,X,newnum);
Ynew=interp1(num,Y,newnum);
