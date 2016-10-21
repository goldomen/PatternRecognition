clear all
close all

load('kmeans1.mat');
dataSize=size(kmeans1);
diff=1;

randData=randperm(dataSize(1));
k=2;
clusterClass=0:1:k-1;
classVector=[];

vector=zeros(k,dataSize(2));

for j=1:k
    vector(j,:)=kmeans1(randData(j),:);
end
%vector(2,:)=[105,6];
firstCluster=vector;

iter=0;
while diff ~= 0
    disp(vector);
    [vector,diff,classData,J_error]=kmeans(vector,kmeans1,k);
    if k==1 
        J_1=J_error;
    end
    iter=iter+1;
    
    disp(iter)
end
figure(1)
scatter(vector(:,1),vector(:,2),100,'*')
for h=1:k
    
        class=find(classData==clusterClass(h));
        hold on
        scatter(kmeans1(class(:),1),kmeans1(class(:),2))
   
    
end
