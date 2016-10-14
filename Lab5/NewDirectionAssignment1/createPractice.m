function [x]=createPractice(data1,data2,count1,count2)

sD=size(data1);
x=zeros(count1+count2,sD(2));

mean1=mean(data1);
mean2=mean(data2);

k=1;

for i =1:count1
    if count1~=0
    vectmin=mean1-1;
    vectmax=mean1+1;
    
    x(k,1)=(vectmin(1)+rand*(vectmax(1)-vectmin(1)));
    x(k,2)=(vectmin(2)+rand*(vectmax(2)-vectmin(2)));
    k=k+1;
    end
end

for j=1:1:count2
    if count2~=0
    vectmin=mean2-1;
    vectmax=mean2+1;
    
    x(k,1)=(vectmin(1)+rand*(vectmax(1)-vectmin(1)));
    x(k,2)=(vectmin(2)+rand*(vectmax(2)-vectmin(2)));
    k=k+1;
    end
end