%%part 1
im1 = zeros(50, 50);
im1(15, 15) = 255;
figure
imshow(im1);
[h1, theta1, rho1] = hough(im1);
figure
 imshow(imadjust(mat2gray(h1)),[],...
 'XData',theta1,...
 'YData',rho1,...
 'InitialMagnification','fit');
 xlabel('\theta (degrees)')
 ylabel('\rho')
 axis on
 axis normal
 hold on
 colormap(hot) 

%%part 2
im2 = zeros(50, 50);
im2(15, 15) = 255;
im2(15, 45) = 255;
im2(40, 23) = 255;
figure
imshow(im2);
[h2, theta2, rho2] = hough(im2);
figure
 imshow(imadjust(mat2gray(h2)),[],...
 'XData',theta2,...
 'YData',rho2,...
 'InitialMagnification','fit');
 xlabel('\theta (degrees)')
 ylabel('\rho')
 axis on
 axis normal
 hold on
 colormap(hot) 

%%part 3
im3 = zeros(50, 50);
im3(30, 10) = 255;
im3(30, 25) = 255;
im3(30, 45) = 255;
figure
imshow(im3);
[h3, theta3, rho3] = hough(im3);
figure
 imshow(imadjust(mat2gray(h3)),[],...
 'XData',theta3,...
 'YData',rho3,...
 'InitialMagnification','fit');
 xlabel('\theta (degrees)')
 ylabel('\rho')
 axis on
 axis normal
 hold on
 colormap(hot) 
 
%part 5
p3 = houghpeaks(h3, 1, 'threshold', ceil(0.3*max(h3(:))));
disp('hough peaks');
disp(p3);
x = theta3(p3(:, 2));
y = rho3(p3(:, 1));
plot(x, y, 's', 'color', 'red', 'LineWidth',2, 'MarkerSize',10);

%%part 6
lines3 = houghlines(im3, theta3, rho3, p3, 'FillGap', 20, 'MinLength', 7);
figure, imshow(im3), hold on
xy = [lines3(1).point1; lines3(1).point2];
plot(xy(:,1), xy(:,2), 'LineWidth', 1, 'Color', 'green');  
plot(xy(1,1),xy(1,2),'x','LineWidth',0.5,'Color','yellow');
plot(xy(2,1),xy(2,2),'x','LineWidth',0.5,'Color','yellow');
 
%%part 7
%read image and compute edges
im4 = imread('chess.jpg');
figure
imshow(im4);
bw4 = edge(rgb2gray(im4), 'canny');
figure, imshow(bw4);
%hough transform
[h4, theta4, rho4] = hough(bw4);
figure
 imshow(imadjust(mat2gray(h4)),[],...
 'XData',theta4,...
 'YData',rho4,...
 'InitialMagnification','fit');
 xlabel('\theta (degrees)')
 ylabel('\rho')
 axis on
 axis normal
 hold on
 colormap(hot) 
 %finding peaks
 p4 = houghpeaks(h4, 15, 'threshold', ceil(0.3*max(h4(:)))); 
 %maximum peak
 p4max = houghpeaks(h4, 1, 'threshold', ceil(0.3*max(h4(:)))); 
 x = theta4(p4max(:,2));
 y = rho4(p4max(:,1));
 plot(x, y, 's', 'color', 'black','LineWidth',2, 'MarkerSize',10); 
 %extracting and displaying lines
 lines4 = houghlines(bw4,theta4,rho4,p4,'FillGap',10,'MinLength',15);
 %determine strongest lines
 %creating array of lengths of lines
 lineLengths = zeros(1, length(lines4));
 for i=1:length(lineLengths)
    xy = [lines4(i).point1; lines4(i).point2];
    lineLengths(i) = sqrt((xy(1,1) - xy(2,1))^2+(xy(1,2) - xy(2,2))^2);
 end
 %sorting the lengths of lines in descending order
 [maxLengths, strongestIndex] = sort(lineLengths, 'descend');
 %displaying 15 strongest lines
 figure, imshow(im4), hold on
 for k = 1:min(length(strongestIndex), 15);
     xy = [lines4(strongestIndex(k)).point1; lines4(strongestIndex(k)).point2];
     plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
     plot(xy(1,1),xy(1,2),'x','LineWidth',0.5,'Color','yellow');
     plot(xy(2,1),xy(2,2),'x','LineWidth',0.5,'Color','yellow');
 end 