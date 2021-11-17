clc; clear all; close all
load('Plant1.mat'); load('Plant11.mat'); load('Plant111.mat')
FS=22;
%%
% figure('position',[100,50,500,400]) %[left bottom width height]
% set(gca,'position',[0.,0.01,0.98,0.98])   
% subplot(1,2,1)
% subplot('position',[0.08 0.15 0.40 0.80]);
% figure('position',[100,100,500,500]) %[left bottom width height]
% x=1:300;
% xq = 0:0.1:300;
% P1=plant11;
% P2=plant11;
% P3=plant111;
% Pq1 = interp1(x,P1,xq);
% Pq2 = interp1(x,P2,xq);
% Pq3 = interp1(x,P3,xq);
% 
% plot(xq,Pq1,'-','linewidth',2); hold on; 
% plot(xq,Pq2,'--','linewidth',2);
% plot(xq,Pq3,'-.','linewidth',2);
% 

% % set(gca,'linewidth',2,'fontsize',FS,'ticklength',[0.020 0.015],'xminortick','off')
% set(gca,'linewidth',2,'fontsize',FS,'ticklength',[0.020 0.015],'xminortick','on','yminortick','on')
% xlabel('Time, $t$','fontsize',FS,'Interpreter','latex')
% ylabel('Rescaled plant biomass, $P/\mathcal{P}^*$','fontsize',FS,'Interpreter','latex')
% ytickformat('%1.1f')
% xlim([0 250])
% ylim([0.0 4.0])
% legend('Sulfide-toxicity FCs','Nutrient-depletion FCs','Turing-like FCs','box','off')
% subplot(1,2,2)
% subplot('position',[0.58 0.15 0.4 0.80]);
% plot(dat1(:,1),dat1(:,3),'-','linewidth',2); hold on; 
% plot(dat2(:,1),dat2(:,3),'--','linewidth',2)
% set(gca,'linewidth',2,'fontsize',FS,'ticklength',[0.020 0.010],'xminortick','off')
% yticks(0:0.1:0.4);
% xlabel('Strength of sulfide feedback, $c$','fontsize',FS,'Interpreter','latex')
% ylabel('Sulfide concentrations, $S$ ($\mu$g/L)','fontsize',FS,'Interpreter','latex')
% xlim([0 15]); ylim([0.09 0.4]);
% save2pdf('Resilience')

%%
figure('position',[100,100,600,500]) %[left bottom width height]

bardat=[46 89];
X = categorical({'Patterns intact','Homogeneity'});
X = reordercats(X,{'Patterns intact','Homogeneity'});
tp = tiledlayout(2,1,'TileSpacing','Compact');
tp.TileSpacing = 'compact';
tp.Padding = 'compact';
% subplot(2,1,1)
% nexttile
bar(X,bardat)

% xlabel('Time, $t$','fontsize',FS,'Interpreter','latex')
% ylabel('FPT to $\mathcal{P}^*$','fontsize',FS,'Interpreter','latex')
ytickformat('%1.0f')
% xlim([0 250])
ylim([0.0 100])
set(gca,'linewidth',2,'fontsize',FS,'ticklength',[0.020 0.015],'xminortick','off')
% 
% % subplot(2,1,2)
% nexttile
% bardat2=[3 21; 137 79];
% X2 = categorical({'Model II','Model III'});
% X2 = reordercats(X2,{'Model II','Model III'});
% bar(X2,bardat2)
% 
% % xlabel('Time, $t$','fontsize',FS,'Interpreter','latex')
% % ylabel(t,'Size (mm)')
ylabel(tp,'Recovery time to $\mathcal{P}^*$','fontsize',FS,'Interpreter','latex')
% 
% ytickformat('%1.0f')
% ylim([0.0 160])
% legend('Homog. state', 'FC patterns','location','northwest')
% legend('boxoff')
% set(gca,'linewidth',2,'fontsize',FS,'ticklength',[0.020 0.015],'xminortick','off')

save2pdf('Fig5p4RecoveryTime')
