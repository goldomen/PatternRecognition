%number of people
numPersons = 20;
%length of iris codes
codeLength = 30;
%length of file names, for generating strings
fileNameLength = 12;
size = 1000;

%%%%%%%%%%%
%PART I

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

save('hdsets.mat', 'S', 'D');