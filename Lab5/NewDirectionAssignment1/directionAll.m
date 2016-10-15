function [dir]=directionAll(P,w,data,training,learn)

sD=size(data);
dir=P;
%[minV,index] = findWinner(P,data);
for i=1:sD(1)
    
    if training(i)==w
        direct=1;
    else
        direct=-1;
    end
    
    dir=dir+learn*direct*(data(i,:)-P);
end
    
end
