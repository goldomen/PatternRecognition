clear all
close all

load data_lvq_A(1).mat
load data_lvq_B(1).mat


learn=0.10;
nr_of_classes = 2;
%chunking the data together
data=[matA ; matB];
sD=size(data);
% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

%Create a zero vector, for the plot based on the amount of epochations in
%each case.
zPlot=zeros(1,1000);


% If i want to plot...
figure(1)
scatter(matA(:,1),matA(:,2),'+')
hold on
scatter(matB(:,1),matB(:,2),'o')

%number of practice points for each class.
numclass1=1; 
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

%errj -> epochations of steps with the same arror
% let the first error be 0, before LVQ is used.(for the current data)
%winner represents the winner vector.
%saving a value for epoch to plot the error
epoch=1;
errj=0;
error0=0;
class=zeros(1,numclass1+numclass2);

winner=zeros(numclass1+numclass2,nr_of_classes);
%creates the practice points
practiceVector=createPractice(matA,matB,numclass1,numclass2);
%Find the first winning vectors
for i=1:(numclass1+numclass2)   
    insqrt=zeros(1,sD(2));
    %calculates the euclidean distance
    [valD,ind] = findWinner(practiceVector(i,:),data); 
    class(i)=class_labels(ind);
    winner(i,:)=data(ind,:);
end  

%a big vector to contain the error values
errVector=zeros(1,1000);
epoch=1;
while errj<5

%now for the approximate winner location 
for j=1:(numclass1+numclass2)
winner(j,:)=directionAll(winner(j,:),w(j),data,class_labels,learn);
end

%the miss/hit rate for the already classified points based on the practice
%poitns.
error=zeros(1,200); 
for k=1:sD(1) 
    [val,index]=findWinner(data(k,:),winner);
    if class_labels(k)==w(index)
        error=error+1;
    end
end
errRes=sum(error)/(sD(1))^2;
if error0==errRes 
    errj=errj+1;
end
errVector(epoch)=errRes;
epoch=epoch+1;

error=0;
error0=errRes;
errRes=0;
end
figure(2)
plot(1:epoch-1,errVector(1:epoch-1))