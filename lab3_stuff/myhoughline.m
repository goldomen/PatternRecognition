function [x,y]=myhoughline(H,theta,rho)

%First we find the first peak of the image.
 P = houghpeaks(H,1,'threshold',ceil(0.3*max(H(:)))); 
 thetaP=-theta(P(2));
 %thetaP=pi/4;
 rhoP=rho(P(1)); 
 x=rhoP*cos(thetaP); 
 y=rhoP*sin(thetaP);
 
 
 phi=atan(y/x)+pi/2; 
 m=y-tan(phi)*x;
 
 
%Define the point
 P=[x,y];
 
 %find the pendecular lines
 X=[-2*rhoP:2*rhoP]; 
 Y=X*tan(phi)+m;
%  %Y=X*tan(phi)+m;
 

 X0=[0,x]; 
 Y0=[0,y];

 figure
 plot(X,Y,'blue')
 xlim([-rhoP*1.3 rhoP*1.3])
 ylim([-rhoP*1.3 rhoP*1.3])
 hold on 
 plot(X0,Y0,'--')
 hold on 
 plot(zeros(1,rhoP*4+1),[-rhoP*2:rhoP*2],'black')
 hold on 
 plot([-rhoP*2:rhoP*2],zeros(1,rhoP*4+1),'black')
 
%  disp(phi-atan(y/x))
%  disp(rad2deg(atan(y/x))) 
%  disp(thetaP)
 
 
end