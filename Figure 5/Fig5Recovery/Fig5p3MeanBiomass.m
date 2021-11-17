clc; clear all; close all;
load('plant11.mat'); load('plant111.mat');
% load('plant22.mat'); load('plant222.mat');
% load('plant33.mat'); load('plant333.mat');
%% all
figure('position',[100,100,600,500]) %[left bottom width height]
plot(plant11,'b-','linewidth',2); hold on; 
plot(plant111,'b--','linewidth',2); hold on;
% plot(plant22/plant22(1000),'r-','linewidth',2); hold on; 
% plot(plant222/plant222(1000),'r--','linewidth',2); hold on; 
% plot(plant33/plant33(300),'k-','linewidth',2); hold on; 
% plot(plant333/plant333(300),'k--','linewidth',2); hold on;
FS=24
% set(gca,'linewidth',2,'fontsize',FS,'ticklength',[0.020 0.010],'xminortick','off')
set(gca,'ytick',[0.2:0.05:0.36],'linewidth',2,'fontsize',FS,'ticklength',[0.020 0.015],...
    'xminortick','off','yminortick','off');
xlabel('Time after disturbance, $t$','fontsize',FS,'Interpreter','latex')
ylabel('Post-disturbance recovery, $\langle P_m\rangle$','fontsize',FS,'Interpreter','latex')
ytickformat('%1.2f')
xlim([0 80])
ylim([0.19 0.36])
legend('Patterns intact','Homogeneity','Patterns intact2','Homogenized2','Patterns intact3','Homogenized3','box','off')
% yticks(0:0.1:0.4);
save2pdf('Fig5p3MeanBiomass')