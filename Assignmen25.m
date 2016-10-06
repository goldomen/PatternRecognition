clear all;
load lab3_2.mat;

data = lab3_2;
nr_of_classes = 4;

% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

err = zeros(1,13);

for K = 1:2:25

    error = 0;
    for d = 1:length(data)
        tempData = data;
        tempData(d,:) = [];
        tempLabel = class_labels;
        tempLabel(d) = [];
        disp(data(d))
        if class_labels(d) ~= KNN(data(d,:),K,tempData,tempLabel)
            error = error + 1;
        end
    end

    err(1,(K+1)/2) = error / length(data);
end
figure(2)
plot(1:2:25,err)
    
