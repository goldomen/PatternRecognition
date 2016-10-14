clear all
load('data_lvq_A.mat');
load('data_lvq_B.mat');

%chunking the data together
data=[matA ; matB];
nr_of_classes = 2;
% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data));

%prototype vectors
%prot(:,1) stores values of the first feature
%prot(:,2)  - of the second feature
%prot(:,3) - class label
prot = zeros(3,3);
%let's take mean of class B as prototype vector of class B.
prot(1, 1) = sum(matB(:, 1)) / 100;
prot(1, 2) = sum(matB(:, 2)) / 100;
prot(1, 3) = 1;
prot(2, 1) = sum(matA(:, 1)) / 100 + 1.5;
prot(2, 2) = sum(matA(:, 2)) / 100;
prot(2, 3) = 0;
prot(3, 1) = sum(matA(:, 1)) / 100 - 1.5;
prot(3, 2) = sum(matA(:, 2)) / 100;
prot(3, 3) = 0;

%copy of prototypes for future use
prototype = prot;

%plotting initial prototypes
figure
plot(prot(1, 1), prot(1, 2), '*', 'Color', 'black');
hold on
plot(prot(2, 1), prot(2, 2), 'o', 'Color', 'red');
hold on
plot(prot(3, 1), prot(3, 2), 'x', 'Color', 'blue');
hold on
title('Initial Prototypes');
xlabel('First Feature');
ylabel('Second Feature');
legend('prot. of B','1st prot. of A','2nd prot. of A');

%Relevance LVQ
%learning rate of relevances should be significantly smaller than the
%learning rate of prototypes.
learning_rate_prot = 0.01;
learning_rate_rel = 0.0001;
%global relevances
rel1 = 0.5;
rel2 = 0.5;
error_old = 100;
%stores number of epochs
epochs = 0;
%stores the values of relevances and test error for every epoch
dataForPlotting = zeros(0, 3);
while true
   epochs = epochs + 1;
   error_new = 0;
   for i=1:200
      %calculate distances to the prototypes
      dist = zeros(1, 3);
      for j=1:3
         dist(j) = rel1*(prot(j,1) - data(i,1))^2 + rel2*(prot(j,2) - data(i,2))^2;
      end
      [M,I] = min(dist);
      %update closest prototype and relevances
      if (prot(I,3) ~= class_labels(i))
          error_new = error_new + 1;
          prot(I, 1) = prot(I, 1) - learning_rate_prot * (data(i, 1) - prot(I, 1));
          prot(I, 2) = prot(I, 2) - learning_rate_prot * (data(i, 2) - prot(I, 2));
          rel1 = rel1 + learning_rate_rel * abs(data(i, 1) - prot(I, 1));
          rel2 = rel2 + learning_rate_rel * abs(data(i, 2) - prot(I, 2));
      else
          prot(I, 1) = prot(I, 1) + learning_rate_prot * (data(i, 1) - prot(I, 1));
          prot(I, 2) = prot(I, 2) + learning_rate_prot * (data(i, 2) - prot(I, 2));
          rel1 = rel1 - learning_rate_rel * abs(data(i, 1) - prot(I, 1));
          rel2 = rel2 - learning_rate_rel * abs(data(i, 2) - prot(I, 2));
      end
      %Enforcing rel1 + rel2 = 1;
      rel1tmp = rel1;
      rel1 = rel1 / (rel1 + rel2);
      rel2 = rel2 / (rel1tmp + rel2);
   end
   error_new = error_new / 200;
   dataForPlotting = [dataForPlotting; [rel1 rel2 error_new]];
   if abs(error_old - error_new) < 0.0001
       break;
   end
   error_old = error_new;
end

%Final relevances
disp(rel1);
disp(rel2);

%Final prototypes
figure
plot(prot(1, 1), prot(1, 2), '*', 'Color', 'black');
hold on
plot(prot(2, 1), prot(2, 2), 'o', 'Color', 'red');
hold on
plot(prot(3, 1), prot(3, 2), 'x', 'Color', 'blue');
hold on
xlabel('First Feature');
ylabel('Second Feature');
title('Final Prototypes');
legend('prot. of B','1st prot of A','2nd prot of A', 'Location', 'South');

%plotting relevances and error for each epoch
figure
plot(1:epochs, dataForPlotting(:, 1));
hold on
plot(1:epochs, dataForPlotting(:, 2));
hold on
plot(1:epochs, dataForPlotting(:, 3));
hold on
title('Relevances and Training Error as Functions of Number of Epochs');
xlabel('Number of Epochs');
ylabel('Relevances and Training Error');

%%10-fold cross validation
idx = randperm(200);
test_error = 0;
for t=1:10
   %copy the original prototypes
   prot = prototype;
   %initial values of global relevances
   rel1 = 0.5;
   rel2 = 0.5;
   %learning rate for prototypes and relevances
   learning_rate_prot = 0.01;
   learning_rate_ret = 0.0001;
   error_old = 100;
   while true
       error_new = 0;
       for i=1:length(idx)
          %do not use test data for training
          if i >= (t-1)*10 + 1 && i <= t*10
              continue;
          end
          %calculate distances to the prototypes
          dist = zeros(1, 3);
          for j=1:3
             dist(j) = rel1*(prot(j,1) - data(idx(i),1))^2 + rel2*(prot(j,2) - data(idx(i),2))^2;
          end
          [M,I] = min(dist);
          %update closest prototype and relevances
          if (prot(I,3) ~= class_labels(idx(i)))
              error_new = error_new + 1;
              prot(I, 1) = prot(I, 1) - learning_rate_prot * (data(idx(i), 1) - prot(I, 1));
              prot(I, 2) = prot(I, 2) - learning_rate_prot * (data(idx(i), 2) - prot(I, 2));
              rel1 = rel1 + learning_rate_rel * abs(data(idx(i), 1) - prot(I, 1));
              rel2 = rel2 + learning_rate_rel * abs(data(idx(i), 2) - prot(I, 2));
          else
              prot(I, 1) = prot(I, 1) + learning_rate_prot * (data(idx(i), 1) - prot(I, 1));
              prot(I, 2) = prot(I, 2) + learning_rate_prot * (data(idx(i), 2) - prot(I, 2));
              rel1 = rel1 - learning_rate_rel * abs(data(idx(i), 1) - prot(I, 1));
              rel2 = rel2 - learning_rate_rel * abs(data(idx(i), 2) - prot(I, 2));
          end
       end
       error_new = error_new / 190;
       if abs(error_old - error_new) < 0.00001
           break;
       end
       error_old = error_new;
   end
   %testing
   error_tmp = 0;
   for i=(t - 1) * 10 + 1 :  t * 10
       dist = zeros(1, 3);
          for j=1:3
             dist(j) = rel1*(prot(j,1) - data(idx(i),1))^2 + rel2*(prot(j,2) - data(idx(i),2))^2;
          end
          [M,I] = min(dist);
          if (prot(I,3) ~= class_labels(idx(i)))
              error_tmp = error_tmp + 1;
          end
   end
   test_error = test_error + error_tmp / 10;
end
test_error = test_error / 10;
disp('Test Error:');
disp(test_error);
