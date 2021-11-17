clear all; clc; close all
load Afix.mat
load Bfix.mat
%% data requires ascending by x 
a=length(A);
 for ii=1:a
     plot([A(ii,1) B(ii,1)],[A(ii,2) B(ii,2)]);
     hold on
 end
p=[A B];
Result=[];
for iii=1:2000
    %calculate distance
p1= rand(1,4)*max(max(p)); 
z = polyfit([p1(1) p1(3)],[p1(2) p1(4)],1);
xx=1:max(max(A));
yy=polyval(z,xx);
% plot(xx,yy,'k--','linewidth',2')
% xlim([0 max(max(p))]);
% ylim([0 max(max(p))]);
% axis equal
k1=(p1(2)-p1(4))/(p1(1)-p1(3));
b1=p1(2)-k1*p1(1);
num=[];
crosspoint=[];
   for j=1:a
       p2=p(j,:);
       k2=(p2(2)-p2(4))/(p2(1)-p2(3));
       b2=p2(2)-k2*p2(1);
       x=-(b1-b2)/(k1-k2);     % aquire intersection point
       y=-(-b2*k1+b1*k2)/(k1-k2);                                 
        if  min(p2(1),p2(3))<=x && x<=max(p2(1),p2(3)) && ...
        min(p2(2),p2(4))<=y && y<=max(p2(2),p2(4))    
%             plot(x,y,'ro','Markersize',8); 
            num=[num;j]; 
            crosspoint=[crosspoint;[x,y]];
        end
   end
  dis=diag(squareform(pdist(crosspoint)),1);
    % calculate angle
  temp=p(num,:);
  [L,~]=size(temp);
%  for ii=1:L
%      plot([temp(ii,1) temp(ii,3)],[temp(ii,2) temp(ii,4)],'r','linewidth',2);
%  end
  tempvec=[temp(:,3)-temp(:,1) temp(:,4)-temp(:,2)];
  angle=[];
  for ii=1:L-1    
     s=tempvec(ii,:);
     t=tempvec(ii+1,:); 
     if s(2)*t(2)<0
        t=-t;   
     end 
     theta = acosd(dot(s,t)./(norm(s)*norm(t)));
     if (s(2)<0 && t(2)>0) || (s(2)>0 && t(2)>0)  %line 
      theta = -theta;    
     end 
     angle=[angle;theta];
  end
  Result=[[dis angle];Result];
  disp(iii)
end
 %% selected 
Result=real(Result);
Result(Result(:,1)==0,:)=[];
    X = real(Result);
    Lmax = max(X(:,1));
    Lmin = min(X(:,1));
    Amax = max(X(:,2));
    Amin = min(X(:,2));
%   num1=Result(:,1)<50;
%   num2=Result(:,2)<10 & Result(:,2)>-10;
%   select=num1.*num2;
%   Result(select==1,:)=[];
 save Resultfig4p6.mat Result
%% figure 
  figure('position',[100,100,500,500]) %[left bottom width height]
  Result = Result(Result(:,1)<=60,:);
  N=numel(Result)/2;
  [n,bin]=hist3(Result,[25,25]);
   x=bin{1};
   y=bin{2};
   pxy=n/N;
   surf(y,x,pxy)
%
box on
FS=22
set(gca,'xtick',[-200:100:200],'linewidth',2,'fontsize',FS,'ticklength',[0.020 0.015],'xminortick','on','yminortick','on','zminortick','on');
ylabel('Length','fontsize',FS,'Interpreter','latex')
%ylim([0 5.0])
%ytickformat('%1.1f')
% xlabel('Maximum uptake rate of nutrient by plant, $c$','fontsize',FS,'Interpreter','latex')
xlabel('Angle, $c$','fontsize',FS,'Interpreter','latex')
%xlim([0 0.30]);
zlabel('Probability','fontsize',FS,'Interpreter','latex')
 %
save2pdf('Fig4p6AngleS')
%    shading interp 
%    xlim([Amin Amax])
%    ylim([0 60])

%    shading interp 
%    xlim([Amin Amax])
%    ylim([0 60])