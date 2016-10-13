function [dir]=direction(P,w,data,training,learn)

sD=size(data);
dir=P;
d=zeros(1,sD(1));

K=15;

for i=1:sD(1)

d(i)=euclidean(P,data(i,:));

end
datVect=zeros(2,K);
indexVect=zeros(1,K);
for k=1:K 
    [miN,index]=min(d); 
    indexVect(k)=index;
    datVect(:,k)=data(index,:);
    %we don't want the same neightbour to be chosen again....
    d(index)=999;
end

for i=1:K
    if training(indexVect(k))==w
        direct=1;
    else
        direct=-1;
    end
    dir=dir+learn*direct*(data(indexVect(i),:)-P);
end
