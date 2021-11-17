
load('Resultfig4p3.mat')
%% figure 
  figure('position',[100,100,500,500]) %[left bottom width height]
  Result = Result(Result(:,1)<=60,:);
  N=numel(Result)/2;
  [n,bin]=hist3(Result,[25,25]);
   y=bin{1};
   x=bin{2};
   pxy=1000*n/N;
   [xx,yy]=meshgrid(x,y);
   
   surf(xx,yy,pxy)
 % 
zlim([0 6])
box on
FS=22
set(gca,'xtick',[-200:100:200],'ytick',[0:25:50],'linewidth',2,'fontsize',FS,'ticklength',[0.025 0.02],...
    'xminortick','on','yminortick','on','zminortick','on');
% ylabel('Length','fontsize',FS,'Interpreter','latex')
%ylim([0 5.0])
% ytickformat('%1.1f')
% xlabel('Maximum uptake rate of nutrient by plant, $c$','fontsize',FS,'Interpreter','latex')
% xlabel('Angle, $c$','fontsize',FS,'Interpreter','latex')
%xlim([0 0.30]);
% zlabel('Probability','fontsize',FS,'Interpreter','latex')
% 
shading interp
view(-19,30)

save2pdf('Fig4p3AngleD')
%    shading interp 
%    xlim([Amin Amax])
%    ylim([0 60])