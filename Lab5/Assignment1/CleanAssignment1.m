clear all

load data_lvq_A(1).mat
load data_lvq_B(1).mat

iter=0;
learn=0.15;
nr_of_classes = 2;
%chunking the data together
data=[matA ; matB];
sD=size(data);
% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

%If i want to plot...
%figure(1)
%scatter(matA(:,1),matA(:,2),'+')
%hold on
%scatter(matB(:,1),matB(:,2),'o')

%number of practice points for each class.
numclass1=4; 
numclass2=2;

%creating test points
%Choose manually for class A, since the mean is in the middle, but it split
%apart, and two points should be chosen at both sides.
w=zeros(1,numclass1+numclass2);
k1=1;
for i1=1:numclass1 
   w(k1)=0; 
   k1=k1+1;
end

for i2=1:numclass1 
   w(k1) =1; 
   k1=k1+1;
end

errj=0;
err=0;
error0=0;
class=zeros(1,numclass1+numclass2);
winner=zeros(numclass1+numclass2,nr_of_classes);
%creates the practice points
practiceVector=createPractice(matA,matB,numclass1,numclass2);

for i=1:(numclass1+numclass2)   
    insqrt=zeros(1,sD(1));
    for j=1:nr_of_classes
        insqrt=insqrt+(practiceVector(i,j)-data(:,j)).^2;
    end
    [x,ind]=min(sqrt(insqrt));
    ind=mode(ind);
    class(i)=class_labels(ind);
    winner(i,:)=data(ind,:);
end
while errj<15
    
    
    for k=1:(numclass1+numclass2)
        winner(k,:)=direction(winner(k,:),w(k),data,class_labels,learn);
        [winrar,ind]=findWinner(winner(k,:),data);
        class(k)=class_labels(ind);
        if class(k)~=w(k)
            err=err+1;
        end
    end
    
    
    error=err/(numclass1+numclass2);
    if error==error0
        errj=errj+1;
    else
        errj=0;
    end
    error0=error;
    err=0;
    iter=iter+1;
    disp(iter)
end
disp(iter)
disp(error)