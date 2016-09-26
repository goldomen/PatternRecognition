im=imread('Cameraman.tiff'); 
imshow(im) 

%Now begin the Canny Algorithm
rotI = imrotate(im,33,'crop');
 imshow(rotI)
%FIND EDGES
 BW = edge(rotI,'canny');
 imshow(BW);
%COMPUTE THE HOUGH TRANSFORM
 [H,theta,rho] = hough(BW);
 
 %DISPLAY THE RESULT OF THE HOUGH TRANSFORM
 figure
 imshow(imadjust(mat2gray(H)),[],...
 'XData',theta,...
 'YData',rho,...
 'InitialMagnification','fit');
 xlabel('\theta (degrees)')
 ylabel('\rho')
 axis on
 axis normal
 hold on
 colormap(hot) 
 
 %FIND PEAKS
 P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
%SUPERIMPOSE THE PEAKS IN THE HT
 x = theta(P(:,2));
 y = rho(P(:,1));
 plot(x,y,'s','color','black'); 
 
 %FIND LINES
 lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',7);
%DISPLAY ORIGINAL IMAGE WITH LINES %SUPERIMPOSED
 figure, imshow(rotI), hold on
 max_len = 0;
 for k = 1:length(lines)
 xy = [lines(k).point1; lines(k).point2];
 plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
 end 