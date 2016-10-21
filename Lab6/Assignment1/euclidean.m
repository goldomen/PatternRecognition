function eucDist=euclidean(vector,data)
dataSize=size(data);
insqrt=0;
eucDist=zeros(1,dataSize(1));
for j=1:dataSize(1)
    for i=1:dataSize(2)
        insqrt=(data(j,i)-vector(i))^2+insqrt;
    end
    eucDist(j)=sqrt(insqrt);
    insqrt=0;
end

end