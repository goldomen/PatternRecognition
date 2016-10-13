function x =euclidean(P,data)
sP=size(P);
insqrt=0;
for i=1:sP(2) 
    insqrt=(P(i)-data(i))^2+insqrt;
end
x=sqrt(insqrt);
end