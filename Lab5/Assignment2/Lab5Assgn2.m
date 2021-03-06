clear all
load('data_lvq_A.mat');
load('data_lvq_B.mat');

%chunking the data together
data=[matA ; matB];
nr_of_classes = 2;
% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data));

%prototype vectors
prot = zeros(3,3);
%let's take mean of class B as prototype vector of class B.
prot(1, 1) = sum(matB(:, 1)) / 100;
prot(1, 2) = sum(matB(:, 2)) / 100;
prot(1, 3) = 1;
%let's calculate prototypes of class A from the value of mean of A.
prot(2, 1) = sum(matA(:, 1)) / 100 + 1.5;
prot(2, 2) = sum(matA(:, 2)) / 100;
prot(2, 3) = 0;
prot(3, 1) = sum(matA(:, 1)) / 100 - 1.5;
prot(3, 2) = sum(matA(:, 2)) / 100;
prot(3, 3) = 0;

%for generating the random subsets
%for generating subsets, we will divide idx into 10 parts are use it's
%elements as indexes of rows of 'data' Matrix. 
idx = randperm(200);
%value of test error computed by the cross validation will be stored here
test_error = 0;
%for each iteration, test indexes of test instances are stored from
%idx((t-1)*10 + 1) to idx(t*10);
for t=1:10
   %copy the original prototypes
   prototype = prot;
   learning_rate = 0.01;
   %we have to stop when difference between errors of different iterations
   %is close to constant. So at first let's assign a large value to
   %'error_old'
   error_old = 100;
   while true
       error_new = 0;
       for i=1:length(idx)
           %skip test data
          if i >= (t-1)*10 + 1 && i <= t*10
              continue;
          end
          %calculate distances to the prototypes
          dist = zeros(1, 3);
          for j=1:3
             dist(j) = (prototype(j,1) - data(idx(i),1))^2 + (prototype(j,2) - data(idx(i),2))^2;
          end
          [M,I] = min(dist);
          %update the prototype that is closest to the current instance
          if (prototype(I,3) ~= class_labels(idx(i)))
              error_new = error_new + 1;
              prototype(I, 1) = prototype(I, 1) - learning_rate * (data(idx(i), 1) - prototype(I, 1));
              prototype(I, 2) = prototype(I, 2) - learning_rate * (data(idx(i), 2) - prototype(I, 2));
          else
              prototype(I, 1) = prototype(I, 1) + learning_rate * (data(idx(i), 1) - prototype(I, 1));
              prototype(I, 2) = prototype(I, 2) + learning_rate * (data(idx(i), 2) - prototype(I, 2));
          end
       end
       error_new = error_new / 190;
       %stop when error does not change much anymore
       if abs(error_old - error_new) < 0.00001
           break;
       end
       error_old = error_new;
   end
   %calculating test error
   error_tmp = 0;
   for i=(t - 1) * 10 + 1 :  t * 10
       dist = zeros(1, 3);
          for j=1:3
             dist(j) = (prototype(j,1) - data(idx(i),1))^2 + (prototype(j,2) - data(idx(i),2))^2;
          end
          [M,I] = min(dist);
          if (prototype(I,3) ~= class_labels(idx(i)))
              error_tmp = error_tmp + 1;
          end
   end
   test_error = test_error + error_tmp / 10;
end
test_error = test_error / 10;
disp(test_error);