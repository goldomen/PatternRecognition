function [uData,pData]=prob2(Data,L)
%Data is data on 1 element for each item, L is the size of the data.

uData = unique(Data); 
LuData=size(uData); 
 
j=1;
pData=zeros(size(uData));

%From the uniqe data vector, we create a probability dense function
%Based on the size of the current data used.

for i=1:L(1)
    k=find(uData==Data(i)); 
    pData(k)=pData(k)+1;
    disp(k)
end

%When we just divide the vector, with the amount of elements :^)

pData=pData(1:(LuData(2)));
pData=pData/sum(pData);

end
