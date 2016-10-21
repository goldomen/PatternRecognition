clear all 
close all 
load('checkerboard.mat')

Times=20;
k=100;
error=zeros(2,Times);
options=[0,1];

for i=1:Times 
    for j=1:2
        [cluster,error(j,i)]=kmeansplus(checkerboard,k,options(j),0);
        
    end
end

meanErrPlus=mean(error(2,:));
meanErr=mean(error(1,:));