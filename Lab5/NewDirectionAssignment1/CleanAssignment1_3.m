clear all
close all

load data_lvq_A(1).mat
load data_lvq_B(1).mat

errj=0;
error=100;
oldError=1000;
newError=0;
learn=0.01;
nr_of_classes = 2;
%chunking the data together
data=[matA ; matB];
sD=size(data);
% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );
class_joke_labels=class_labels+2;
% If i want to plot...
figure(1)
scatter(matA(:,1),matA(:,2),'+')
hold on
scatter(matB(:,1),matB(:,2),'o')

%number of practice points for each class.
numclass1=2;
numclass2=2;
totClass=numclass1+numclass2;

%creating test points
%Choose manually for class A, since the mean is in the middle, but it split
%apart, and two points should be chosen at both sides.
w=zeros(1,totClass);
k1=1;
for i1=1:numclass1
    w(k1)=0;
    k1=k1+1;
end

for i2=1:numclass2
    w(k1) =1;
    k1=k1+1;
end

%creates the practice points
practiceVector=createPractice(matA,matB,numclass1,numclass2);
%create an error vector
errorVect=zeros(1,700);
echos=1;
winner=practiceVector;
while errj <5
    newError=errorEst(data,winner,class_labels,w);
    for i=1:totClass
        winner(i,:)=directionAll(winner(i,:),w(i),data,class_labels,learn);
    end
    
    error=abs(oldError-newError);
    errorVect(echos)=newError;
    oldError=newError;
    echos=echos+1;
    if error>0.0001 
        errj=errj+1;
    else
        errj=0;
    end 
    
end
figure(2)
plot(1:echos-1,errorVect(1:echos-1))
