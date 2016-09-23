%Assignment 1.
clear all
%set of feature vectors
%columns represent features, rows represent measurements
A = [4 5 6; 6 3 9; 8 7 3; 7 4 8; 4 6 5];
%computing the mean of set A
mean = mean(A);
disp(mean);
%computing the covariance matrix of set A
covMat = cov(A);
disp(covMat);
%points, where the value of pdf should be calculated
X = [5 5 6; 3 5 7; 4 6.5 1];
%calculating values of pdf
res = mvnpdf(X, mean, covMat);
disp(res);