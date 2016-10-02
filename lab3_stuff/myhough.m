function [H]=myhough(BW)
s=size(BW);
theta=[-pi/2:pi/1024:pi]; 
%theta=[0:pi/128:4*pi]; 
rho=[0:1:s(1)*1.5]; 

non0=find(BW==1); 
nony0=fix(non0/s(1));
deci0=(non0/s(1))-nony0;
nonx0=fix(s(1).*deci0);
s1=size(nonx0);
sR=size(rho);
sT=size(theta);
H=zeros(sR(2),sT(2));
disp(size(H))
disp(sR(2))
disp(size(nony0))
max(nonx0)
for i=1:s1(1)
    for j=1:sT(2);
        
        rhox=nonx0(i,1)*cos(theta(j))+nony0(i,1)*sin(theta(j)); 
        rhox=ceil(rhox);
%             
             if rhox > sR(2) 
                 rhox=sR(2);
             end
%         if rhox < 0
%           rhoP=abs(round((rhox)+1));
%           if rhoP < 1 
%               rhoP=1;
%           end
%         else 
%             rhoP=round(mrho(2)+rhox);
%             
%             if rhoP > sR(2) 
%                 rhoP=sR(2);
%             end
%             
%             
%         H(rhoP,j)=H(rhoP,j)+1;
%         end
if rhox >0
        H(rhox,j)=H(rhox,j)+1;
end
    end
end

theta=rad2deg(theta);

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

end