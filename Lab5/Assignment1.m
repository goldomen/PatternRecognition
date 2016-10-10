load data_lvq_A(1).mat
load data_lvq_B(1).mat

learn=0.1;
nr_of_classes = 2;
data=[matA ; matB];
% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );
figure(1)
scatter(matA(:,1),matA(:,2),'+')
hold on
scatter(matB(:,1),matB(:,2),'o')
meanDA=mean(matA);
meanDB=mean(matA);

%get 3 points near the mean at random for testing
minA1=[2.3,5.1]-0.5;
maxA1=minA1+1;

minA2=[7.2,4.6]-0.5;
maxA2=minA2+1;


minB=meanDB-0.5;
maxB=meanDB+0.5;

%creating test points
testPoints=zeros(3,2);
%Choose manually for class A, since the mean is in the middle, but it split
%apart, and two points should be chosen at both sides.
vectmin=[];
class=zeros(1,3);
for i=1:3
    if i ==1
        vectmin=minA1;
        vectmax=maxA1;
    elseif i==2
        vectmin=minA2;
        vectmax=maxA2;
    else
        vectmin=minB;
        vectmax=maxB;
    end
    testPoints(i,1)=(vectmin(1)+rand*(vectmax(1)-vectmin(1)));
    testPoints(i,2)=(vectmin(2)+rand*(vectmax(2)-vectmin(2)));
    
    insqrt=0;
    for j=1:nr_of_classes
        insqrt=insqrt+(testPoints(i,j)-data(:,j)).^2;
    end
    [x,ind]=min(sqrt(insqrt));
    class(i)=class_labels(ind);
end
disp(testPoints)
disp(class)