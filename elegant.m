clear all
close all

%Let's first load the data of the people in question
load('lab1_1.mat')
L=size(lab1_1);
%We create the matrices for the information for height, age and weight.
age=zeros(24); 
height=zeros(24); 
weight=zeros(24); 

%Now we need to make a probability vector of the values in the matrice. 


%the next step is to fill the matrices with the pair wise correleation. 
%Covariance divided by the square root of their variances. 
%first calculate the mean between the elements 

%Height, rotate just because the vector multiplication worked then.
Height=lab1_1(:,1);
Height=rot90(Height);
meanH=meanPair(Height,L);

%Age, rotate just because the vector multiplication worked then.
Age=lab1_1(:,2);
Age=rot90(Age);
meanA=meanPair(Age,L);


%Weight, rotate just because the vector multiplication worked then.
Weight=lab1_1(:,3);
Weight=rot90(Weight);
meanW=meanPair(Weight,L);
%Try two, without mathlab build in methods
%Age, uses the probability function, to get the unique vector and the
%probability dense function.
[uAge,pAge]=prob2(Age,L);

%height, uses the probability function, to get the unique vector and the
%probability dense function.
[uHeight,pHeight]=prob2(Height,L);

%Weight, uses the probability function, to get the unique vector and the
%probability dense function.
[uWeight,pWeight]=prob2(Weight,L);

%The probability based on that the elements are not codependent.
pVector=zeros(24,1); 
pVect=[Height;Age;Weight];
for i=1:24 
    %Height
    k1=find(uHeight==pVect(1,i))
    %Age 
    k2=find(uAge==pVect(2,i))
    %Weight pVector
    k3=find(uWeight==pVect(3,i))
     
    pVector(i)=(pHeight(k1)+pAge(k2)+pWeight(k3))/3;
end

%The loop above... seems to calculate the wrong stuff for the pVector
%However, if we can find matlab functions that does this whole part faster,
%I'm all up for it!!! (and easier)
