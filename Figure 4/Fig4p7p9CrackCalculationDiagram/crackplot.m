
%% original plot
clear all; clc; close all
Aread=xlsread('2.crack300.xlsx');
A=Aread(:,7:8);% start point
B=Aread(:,10:11);% end point
 for ii=1:length(A);
     plot([A(ii,1) B(ii,1)],[A(ii,2) B(ii,2)]);
     title('Original plot') 
     hold on
 end
%% contract to one point
D=[A;B];
Dfix=D;
Ldis=min(Aread(:,3));% The minimum of the side length 
                     % as the threshold value of distance
for ii=1:length(D)
    dis=sqrt(sum((D-D(ii,:)).^2,2));
    num=dis < Ldis & dis > 0;
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
%% plot after contract 
figure
 for ii=1:length(A)
     plot([A(ii,1) B(ii,1)],[A(ii,2) B(ii,2)],'linewidth',3.0);
     axis off
%      title('Plot after contract') 
     hold on
 end
%  save Afix.mat A 
%  save Bfix.mat B
save2pdf('crackplot300')
%% 
ID=Aread(:,1)';
Area=Aread(:,2)';
Length=Aread(:,3)';
dfittool(Length)

Width=Aread(:,4)';
Direction=Aread(:,5)';
dfittool(Direction)


