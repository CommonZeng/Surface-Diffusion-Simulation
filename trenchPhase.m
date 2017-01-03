% trench1(radius, depth, fileOpenName, tMax, accuracy)
% clear all;
% radius=[9:1:26];
% depth=[300];
% for ii=1:1:length(radius)
%     for jj=1:1:length(depth)
%         for kk=0:1:15
%             trench2(radius(ii), depth(jj), 25*kk, 25*(kk+1));
%         end;
%     end;
% end;


%trench2(5, 150, 280, 290);
 for kk=0:1:79
 trench2(25, 600, 25*kk, 25*(kk+1));
 end;