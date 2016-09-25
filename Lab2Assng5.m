%Assingment 5
clear all
m1 = [3; 5];
m2 = [2; 1];
S1 = [1 0; 0 4];
S2 = [2 0; 0 1];
%determinant of S1
det1 = det(S1);
%determinant of S2
det2 = det(S2);
%inverse of S1
S1inv = inv(S1);
%inverse of S2
S2inv = inv(S2);
%computing the decision boundary
syms x
syms y
syms X
X = [x;y];
g1=log(1/(2*pi*sqrt(det1))) + (-1)/2*(X-m1)'/S1*(X-m1)+log(0.3);
g2=log(1/(2*pi*sqrt(det2))) + (-1)/2*(X-m2)'/S2*(x-m2)+log(0.7);
eqn = g1 - g2 == 0;
assume(x, 'real');
assume(y, 'real');
res = solve(eqn, x, y);
disp(res.x);
disp(res.y);
figure;
plot(res.x, res.y);
figure;
scatter(res.x, res.y);