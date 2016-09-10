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
Age=sort(lab1_1(:,2));
Age=rot90(Age);
Age=[Age,0];

Height=sort(lab1_1(:,1));
Height=rot90(Height);
Height=[Height,0];

Weight=sort(lab1_1(:,3));
Weight=rot90(Weight);
Weight=[Weight,0];
%the next step is to fill the matrices with the pair wise correleation. 
%Covariance divided by the square root of their variances. 
%first calculate the mean between the elements 

%Height
for k=1:24 
     i=k;
        for j=k:L(1)
            meanH=(lab1_1(i,1)+lab1_1(j,1))/2;
            height(j,i)=meanH; 
        end 
    
end 

%Age
for k=1:24 
     i=k;
        for j=k:L(1)
            meanA=(lab1_1(i,2)+lab1_1(j,2))/2;
            age(j,i)=meanH; 
        end 
    
end 

%Weight
for k=1:24 
     i=k;
        for j=k:L(1)
            meanW=(lab1_1(i,3)+lab1_1(j,3))/2;
            weight(j,i)=meanW; 
        end 
    
end 

%then we need to get the probably vector of p(x,y,z) 
% mu = min(Age);
% sigma = max(Age);
% pd = makedist('Normal',mu,sigma);
% y = pdf(pd,Age);

%Try two, without mathlab build in methods
uAge = unique(Age); 
LUAge=size(uAge); 
i=1; 
j=1;
pAge=zeros(size(uAge));
tic
while i<=L(1)
    pAge(j)=pAge(j)+1; 
    if(Age(i)~=Age(i+1))
        j=j+1;
    end
    i=i+1;
end
pAge=pAge(1:(LUAge(2)-1));
pAge=pAge/L(1);
toc

%height
uHeight = unique(Height); 
LUHeight=size(uHeight); 
i=1; 
j=1;
pHeight=zeros(size(uHeight));
tic
while i<=L(1)
    pHeight(j)=pHeight(j)+1; 
    if(Height(i)~=Height(i+1))
        j=j+1;
    end
    i=i+1;
end
pHeight=pAge(1:(LUHeight(2)-1));
pHeight=pHeight/L(1);

%Weight
uWeight = unique(Weight); 
LUWeight=size(uWeight); 
i=1; 
j=1;
pWeight=zeros(size(uWeight));
tic
while i<=L(1)
    pWeight(j)=pWeight(j)+1; 
    if(Weight(i)~=Weight(i+1))
        j=j+1;
    end
    i=i+1;
end
pWeight=pAge(1:(LUWeight(2)-1));
pWeight=pWeight/L(1);