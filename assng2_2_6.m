
numPersons = 20;
codeLength = 30;
fileNameLength = 12;
size = 1000;

load('generatedsets.mat');

%plot histograms of S and D
figure;
histogram(S, 'BinWidth', 0.04);
hold on
histogram(D, 'BinWidth', 0.04);

%means of S and D
meanS = 0; meanD = 0;
for i = 1:size
    meanS = meanS + S(i);
    meanD = meanD + D(i);
end
meanS = meanS / size;
meanD = meanD / size;

disp(meanS);
disp(meanD);

%variances of S and D

varS = 0; varD = 0;
for i = 1:size
    varS = varS + (S(i) - meanS)^2;
    varD = varD + (D(i) - meanD)^2;
end

varS = varS / size;
varD = varD / size;

disp(varS);
disp(varD);
% % normal distributions with the same means and standard deviations as S
% and D
xs = [0:0.01:0.2];
normS = normpdf(xs, meanS, sqrt(varS));
xd = [0:0.01:0.8];
normD = normpdf(xd, meanD, sqrt(varD));
%plotting standard distributions
figure;
plot(xs,normS);
hold on
plot(xd, normD);

%%#5.a.
%finding decision criterion for false acceptance rate of 0.0005.

decisionCritetion = 0;

for d=0.0:0.0001:0.8
    if (normcdf(d, meanD, sqrt(varD)) == 0.0005)
        decisionCriterion = d;
        break;
    end
end

disp(decisionCriterion);
disp(normcdf(decisionCriterion, meanD, sqrt(varD)));

%%#5.b.
%finding false rejection rate for decisionCriterion

%first, let's calculate normcdf for set S and the decision criterion
%calculate by us.
cdfs = normcdf(decisionCriterion, meanS, sqrt(varS));
%false rejection rate will be 1 - cdfs
falseRejetionRate = 1 - cdfs;
disp(falseRejetionRate);

%%6
load('testperson.mat');
load('filenames.mat');

%20 is the number of iris codes of each person
testPersonHdSet = zeros(1, numPersons * 20);

minHD = 50;
personNumber = 0;
rownumber = 0;
index = 0;
for p=1:numPersons
   person = load(Names(p, :));
   for i=1:20
       curHD = 0;
       for j=1:codeLength
           if (iriscode(j) ~= 2 && iriscode(j) ~= person.iriscode(i,j))
               curHD = curHD + 1;
           end
       end
       curHD = curHD / codeLength;
       index = index + 1;
       testPersonHdSet(index) = curHD; 
       if (curHD < minHD)
           minHD = curHD;
           personNumber = p;
           rownumber = i;
       end
   end
end

disp(minHD);
disp(personNumber);
disp(rownumber);

%calculating mean and standard deviation of testPersonHdSet
meantp = 0;
for i = 1:index
    meantp = meantp + testPersonHdSet(i);
end
meantp = meantp / index;

disp(meantp);

vartp = 0;
for i = 1:index
    vartp = vartp + (testPersonHdSet(i) - meantp)^2;
end

vartp = vartp / index;
stdevtp = sqrt(vartp);

disp(stdevtp);

%significance value
sigval = normcdf(minHD, meantp, stdevtp);
display(sigval);

