%% original plot
clear all; clc; close all
Aread=xlsread('WaterCrack.xlsx');
A=Aread(:,6:7);% start point
B=Aread(:,8:9);% end point
 for ii=1:length(A);
     plot([A(ii,1) B(ii,1)],[A(ii,2) B(ii,2)]);
     set(gca,'YDir','reverse')%对Y方向反转
     hold on
 end
%% contract to one point 1
D=[A;B];
Dfix=D;
Ldiss=16%min(Aread(:,3));% The minimum of the side length 
                     % as the threshold value of distance
for ii=1:length(D)
    dis=sqrt(sum((D-D(ii,:)).^2,2));
%     Ldis=min(dis(dis>0))
    num=dis < Ldiss & dis > 0;
    temp=D(num,:);
    if isempty(temp)==0
        newxy=mean([temp;D(dis==0,:)]);
        num=logical(double(num)+double(dis==0));
        Dfix(num,:)=newxy.*ones(sum(num),1);
        disp(ii);
    end
end
A=Dfix(1:length(D)/2,:);
B=Dfix(length(D)/2+1:end,:);
% %% contract to one point 2
% D=[A;B];
% for ii=1:length(D)
%     Distance(ii,:) = norm(B(ii,:)-A(ii,:));
% end
% 
% Dfix=D;
% Ldis=min(Aread(:,3))+1.0;% The minimum of the side length 
%                      % as the threshold value of distance
% for ii=1:length(D)
%     dis=sqrt(sum((D-D(ii,:)).^2,2));
%     num=dis < Ldis & dis > 0;
%     temp=D(num,:);
%     if isempty(temp)==0
%         newxy=mean([temp;D(dis==0,:)]);
%         num=logical(double(num)+double(dis==0));
%         Dfix(num,:)=newxy.*ones(sum(num),1);
%         disp(ii);
%     end
% end
% A=Dfix(1:length(D)/2,:);
% B=Dfix(length(D)/2+1:end,:);
%% plot after contract 
figure
 for ii=1:length(A)
     plot([A(ii,1) B(ii,1)],[A(ii,2) B(ii,2)]);
     %set(gca,'XDir','reverse')%对X方向反转
     set(gca,'YDir','reverse')%对Y方向反转
     hold on
 end
 axis off
 axis equal
%  saveas(gcf,'contract1.png')
 save Afix.mat A 
 save Bfix.mat B
