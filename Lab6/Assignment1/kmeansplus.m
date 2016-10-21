
function [vector,error]=kmeansplus(data,k,option,im)


%prompt = 'Want to use + press 1, othervise 0 ';
%x = input(prompt);
vectorClass=0:1:k-1;
error=0;
if option~=1
    
    dataSize=size(data);
    diff=1;
    
    randData=randperm(dataSize(1));
    
    classVector=[];
    
    vector=zeros(k,dataSize(2));
    
    for j=1:k
        vector(j,:)=data(randData(j),:);
    end
    %vector(2,:)=[105,6];
    firstvector=vector;
    
else
    
    
    dataSize=size(data);
    
    vector=zeros(k,dataSize(2));
    vector(1,:)=data(ceil(rand*dataSize(1)),:);
    
    
    
    %;l
    dist=euclidean(vector(1,:),data);
    Prob=tcdf(dist.^2,dataSize(2));
    
    randsample(1:dataSize(1),1,true,dist.^2)
    
    newIndex=randsample(1:dataSize(1),1,true,dist);
    vector(2,:)=data(newIndex,:);
    
    if k >1
        for j=2:k
            
            dist=zeros(j,dataSize(1));
            distMany=zeros(j,dataSize(1));
            distOne=[];
            for c=1:j
                distMany(c,:)=euclidean(vector(c,:),data);
            end
            
            %5sras
            
            classCent=0:1:k-1;
            classVector=zeros(1,dataSize(1));
            %create an index vector for the each class
            identityVector=zeros(k,dataSize(1));
            %sdsadnasdjkas
            %classify the data points
            for i=1:dataSize(1)
                [miN,index]=min(distMany(:,i));
                classVector(i)=classCent(index);
                %Assterting the identy for a certain index.
                identityVector(index,i)=1;
            end
            %sfsaf
            for l=1:k
                distIndex=find(identityVector(l,:)==1);
                
                for e1=1:length(distIndex)
                    distOne(distIndex(e1))=euclideanOne(vector(l,:),data(distIndex(e1),:));
                end
            end
            newIndex=randsample(1:dataSize(1),1,true,distOne);
            if j~=k
                vector(j+1,:)=data(newIndex,:);
            end
        end
        
        
        
    end
    
end
diff=1;
iter=0;
while diff ~= 0
    
    [vector,diff,classData,J_error]=kmeans(vector,data,k);
    error=error+J_error;
    iter=iter+1;
    
    
end

if im==1
    
    figure(1)
    scatter(vector(:,1),vector(:,2),100,'*')
    for h=1:k
        
        class=find(classData==vectorClass(h));
        hold on
        scatter(data(class(:),1),data(class(:),2))
        
        
    end
end
end
