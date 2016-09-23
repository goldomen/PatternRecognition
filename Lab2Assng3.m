%Assingment 3
clear all
mu = [2 4];
Sigma = [1 0; 0 2];
x1 = -10:.2:10; x2 = -10:.2:10;
[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],mu,Sigma);
%creates matrix from elements of F
F = reshape(F,length(x2),length(x1));
mesh(x1,x2,F);
xlabel('x1'); ylabel('x2'); zlabel('Probability Density');
%calculating the mahalanobis distances
%points of interest
x = [10 10; 0 0; 3 4; 6 8];
%for storing the results
md = zeros(1,4);
for i = 1:4
    xi = x(i,:) - mu;
    md(i) = sqrt(xi/Sigma*xi');
end
disp(md);