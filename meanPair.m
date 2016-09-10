function mean=meanPair(data,L)
%This function calculates the left side for the mean value, pairwise.
%Saves at least some calculations... since the right side would be the
%same.
mean=zeros(L);
for k=1:24 
     i=k;
        for j=k:L(1)
            meanH=(data(i)+data(j))/2;
            mean(j,i)=meanH; 
        end 
    
end 
end