function error=errorEst(data,practice,label,class)
sD=size(data); 
error=0;
for i=1:sD(1) 
    [val,index]=findWinner(data(i,:),practice);
    
    if label(i)~=class(index)
        
        error=error+1;
    end
end 
%disp(error)
error=error/(sD(1));
