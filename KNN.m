function X=KNN(P,K,data,training)

sD=size(data);
d=zeros(1,sD(1));
for j=1:sD(1)

insqrt=0;
for i=1:sD(2)
insqrt=(P(i)-data(j,i))^2+insqrt;
d(j)=sqrt(insqrt);
end

end
detVect=zeros(1,K);
for k=1:K 
    [miN,index]=min(d); 
    datVect(k)=training(index);
    d(index)=999;
end
X=mode(datVect);
end