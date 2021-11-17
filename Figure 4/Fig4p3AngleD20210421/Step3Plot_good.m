clc; clear all; close all;
load('Result.mat')
%% figure 
  figure('position',[100,100,500,500]) %[left bottom width height]
  Result = Result(Result(:,1)<=60,:);
  N=numel(Result)/2;
  [n,bin]=hist3(Result,[25,25]);
   x=bin{1};
   y=bin{2};
   pxy=1000*n/N;
   
   [xx,yy]=meshgrid(y,x);
   [Vxx,Vyy]=meshgrid(linspace(min(y),max(y),100), linspace(min(x),max(x),100));
   Vpxy=interp2(xx,yy,pxy,Vxx,Vyy,'spline');
   surfc(Vxx,Vyy,Vpxy)

 % 
zlim([0 6])
box on
FS=22
set(gca,'linewidth',2,'fontsize',FS,'ticklength',[0.025 0.02],...
    'xminortick','on','yminortick','on','zminortick','on');
% ylabel('Length','fontsize',FS,'Interpreter','latex')
%ylim([0 5.0])
% ytickformat('%1.1f')
% xlabel('Maximum uptake rate of nutrient by plant, $c$','fontsize',FS,'Interpreter','latex')
% xlabel('Angle, $c$','fontsize',FS,'Interpreter','latex')
%xlim([0 0.30]);
% zlabel('Probability','fontsize',FS,'Interpreter','latex')
% 

view(-22,36)

save2pdf('Fig4p3AngleD')
%    shading interp 
%    xlim([Amin Amax])
%    ylim([0 60])