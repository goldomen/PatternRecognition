clear all
close all

load('kmeans1.mat');
dataSize=size(kmeans1);

feature=dataSize(2);

K=20;

D=zeros(1,K) ;
J_vector=zeros(1,K);
R_vector=zeros(1,K);
times=1000;
D_big=zeros(times,K); 
J_vector_big=zeros(times,K); 
R_vector_big=zeros(times,K);

for T=1:times

for k=1:K
    randData=randperm(dataSize(1));
    diff=1;
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
        
        [vector,diff,classData,J_error]=kmeans(vector,kmeans1,k);
        if k==1
            J_1=J_error;
            R_vector(k)=J_1;
            J_vector(k)=J_1;
        else
            R_vector(k)=J_1*k^(-2/feature);
            J_vector(k)=J_error;
        end
        iter=iter+1;
        
        
    end
    D_big(T,k)=R_vector(k)/J_vector(k);
    R_vector_big(T,k)=R_vector(k);
    J_vector_big(T,k)=J_vector(k);
end

end
avarageD=mean(D_big); 
[optK,kIndex]=max(avarageD);
figure(1) 
plot(1:K,avarageD)
hold on 
plot(kIndex,optK,'*')
legend('D(k)', 'Optimal K')
xlabel('K')
ylabel('Value')
strK=num2str(K); 
strTimes=num2str(times);
out=['Plot of D(k) from 1 to ' strK ' with an avarage of ' strTimes ' runs'];
title(out)

% figure(1)
% scatter(vector(:,1),vector(:,2),100,'*')
% for h=1:k
%
%         class=find(classData==clusterClass(h));
%         hold on
%         scatter(kmeans1(class(:),1),kmeans1(class(:),2))
%
%
% end
