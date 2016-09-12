%PART I
numPersons = 20;
codeLength = 30;
fileNameLength = 12;
size = 1000;

Names = repmat(char(0),20,12);

for i = 1:20
    Names(i, :) = sprintf('person%02d.mat',i);
end

%disp(Names)

%generating set S

S = zeros(1, size);

for i = 1:size
    index = randi(numPersons);
    randomFileName = Names(index, :);
    person = load(randomFileName);
    row1 = person.iriscode(randi(20), :);
    %disp(row1);
    row2 = person.iriscode(randi(20), :);
    %disp(row2);
    S(i) = pdist2(row1, row2, 'hamming');
    %disp(S(i));
end

%generating set D

D = zeros(1, size);

for i = 1:size
    index = randi(numPersons);
    randomFileName = Names(index, :);
    person = load(randomFileName);
    row1 = person.iriscode(randi(20), :);
    index = randi(numPersons);
    randomFileName = Names(index, :);
    person = load(randomFileName);
    row2 = person.iriscode(randi(20), :);
    D(i) = pdist2(row1, row2, 'hamming');
end

%PART II
%plot histograms of S and D

histogram(S, 'BinWidth', 0.04);
hold on
histogram(D, 'BinWidth', 0.04);
hold on

%PART II
%means of S and D
meanS = 0; meanD = 0;
for i = 1:size
    meanS = meanS + S(i);
    meanD = meanD + D(i);
end
meanS = meanS / size;
meanD = meanD / size;

%variances of S and D
%variance of a data set

varS = 0; varD = 0;
for i = 1:size
    varS = varS + (S(i) - meanS)^2;
    varD = varD + (D(i) - meanD)^2;
end

varS = varS / size;
varD = varD / size;

xs = [0:0.01:0.2];
normS = normpdf(xs, meanS, sqrt(varS));
xd = [0.2:0.01:0.8];
normD = normpdf(xd, meanD, sqrt(varD));
figure;
plot(xs,normS);
hold on
plot(xd, normD);



