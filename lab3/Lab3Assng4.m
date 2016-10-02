I = imread('HeadTool0002.bmp');
I2 = im2double(I);
figure
imshow(I2);
image = adapthisteq(I2);
figure
imshow(image);
hold on
%finding circles
[centers, radii, metric] = imfindcircles(image, [20 40], 'Sensitivity', 0.91);
viscircles(centers, radii,'EdgeColor','white');
%extracting 2 strongest 
centersStrong2 = centers(1:2,:);
radiiStrong2 = radii(1:2);
metricStrong2 = metric(1:2);
figure
imshow(image);
hold on
viscircles(centersStrong2, radiiStrong2,'EdgeColor','white');
