function [x,ind] = findWinner(P,data) 
sD=size(data);
dist=zeros(1,sD(1));
for i=1:sD(1)
    dist(i)=euclidean(P,data(i,:));
end
[x,ind]=min(dist);
end