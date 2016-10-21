function [newVector,diff,classVector, J_error_sum]=kmeans(inVector, dataset, k)
dataSize=size(dataset);

newVector=zeros(k,dataSize(2));

dist=zeros(k,dataSize(1));
%create class vector
classCent=0:1:k-1;
classVector=zeros(1,dataSize(1));
%create an index vector for the each class
identityVector=zeros(k,dataSize(1));

for j=1:k  
    dist(j,:)=euclidean(inVector(j,:),dataset);
    
end
%classify the data points
for i=1:dataSize(1)
    [miN,index]=min(dist(:,i));
    classVector(i)=classCent(index);
    %Assterting the identy for a certain index.
    identityVector(index,i)=1;
end
partVect=zeros(1,dataSize(2));


sumClass=zeros(1,k); 
for z=1:k
    sumClass(z)=sum(identityVector(z,:));
end

for l=1:k
    for k1=1:dataSize(1)
        if identityVector(l,k1)==1
            partVect=partVect+dataset(k1,:)./sumClass(l);
           
        end
       
    end
    newVector(l,:)=partVect;
        
    
    partVect=zeros(1,dataSize(2));
end
    diff=sum(sum(abs(newVector-inVector)));
    
    %error part
    J_error=zeros(1,k);
    for e=1:k
        errorIndex=find(identityVector(e,:)==1);
        for e1=1:length(errorIndex)
            J_error(e)=J_error(e)+norm(dataset(errorIndex(e1),:)-newVector(e,:))^2;
        end
        
    end
    J_error_sum=sum(J_error)/2;
end