function [x,y]=myhoughline5(H,theta,rho)

%First we find the first peak of the image.
 P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:)))); 
 P1=P(:,1); 
 P2=P(:,2);
 size(P1)
 thetaP=zeros(1,5); 
 rhoP=zeros(1,5);
 for j=1:5
 thetaP(j)=-theta(P2(j));
 rhoP(j)=rho(P1(j));
 end
 
 for i=1:5
 x=rhoP(i)*cos(thetaP(i)); 
 y=rhoP(i)*sin(thetaP(i));
 
 
 phi=atan(y/x)+pi/2; 
 m=y-tan(phi)*x;
 
 
%Define the point
 P=[x,y];
 
 %find the pendecular lines
 X=[-2*rhoP(i):2*rhoP(i)]; 
 Y=X*tan(phi)+m;
%  %Y=X*tan(phi)+m;
 

 X0=[0,x]; 
 Y0=[0,y];

 figure(i)
 xlabel('x')
 ylabel('y')
 plot(X,Y,'blue')
 xlim([-max(rhoP)*1.3 max(rhoP)*1.3])
 ylim([-max(rhoP)*1.3 max(rhoP)*1.3])
 hold on 
 plot(X0,Y0,'--')
 hold on 
 plot(zeros(1,max(rhoP)*4+1),[-max(rhoP)*2:max(rhoP)*2],'black')
 hold on 
 plot([-max(rhoP)*2:max(rhoP)*2],zeros(1,max(rhoP)*4+1),'black')
 end
 
end