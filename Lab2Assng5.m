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
disp(det1);
disp(det2);
%inverse of S1
S1inv = inv(S1);
disp(S1inv);
%inverse of S2
S2inv = inv(S2);
disp(S2inv);
