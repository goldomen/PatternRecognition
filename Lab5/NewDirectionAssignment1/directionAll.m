function [dir]=directionAll(P,w,data,training,learn)

sD=size(data);
dir=P;
K=sD(1);

for i=1:K
    
    if training(i)==w
        direct=1;
    else
        direct=-1;
    end
    
    dir=dir+learn*direct*(data(i,:)-P);
    
end
