### Full Factorial experiment
## packages
library(dplyr)
library(ggplot2)
library(reshape2)
library(RColorBrewer)
library(readxl)
library(ggpubr)
library(afex)
library(ggstatsplot)
library(multcomp)
library(WRS2)
library(car)
library(compute.es); 
library(effects);
library(pastecs)

## import data
CrackPlant <- read_excel("Spatial self-organization in the Yellow River Delta-jiaguo Yan & Johan Van de Koppel 20180404.xlsx", 'Full Factorial experiment')
#CrackPlant <- select(CrackPlant, Treatments, Density, Crack_width, Hardness, Salinity, Water_content)
CrackPlant$Treatments = factor(CrackPlant$Treatments, levels=c('Crack (+), plant (+)','Crack (-), plant (+)','Crack (+), plant (-)','Crack (-), plant (-)')) 

############################ p2: Hardness ############################
p2 <- ggbarplot(CrackPlant, x = "Treatments", y = "Hardness", add = "mean_se",
                color = "Treatments", fill = "Treatments", alpha = 0.5, palette = "jco",
                xlab = "Treatments", ylab = "Hardness (mm)" ) + 
  scale_x_discrete(labels=c("Crack (+), plant (+)" = "Crack (+),\nPlant (+)",
                            "Crack (-), plant (+)" = "Crack (-),\nPlant (+)",
                            "Crack (-), plant (-)" = "Crack (-),\nPlant (-)",
                            "Crack (+), plant (-)" = "Crack (+),\nPlant (-)")) +
  theme_bw() +
  theme(
    panel.border = element_rect(size = 1.0,colour = "black", linetype=1),
    axis.line=element_line(size = 0.6, colour = "black", linetype=1),
    legend.position = "none",#c(0.2,0.8),
    legend.title = element_blank(),
    legend.text = element_text(size = 14,color = "black"),
    legend.background = element_rect(fill = NA,color = NA),
    axis.text.x = element_text(size=16, vjust = 0.5,hjust=0.5,color = 'black'),
    axis.text.y = element_text(size=16, hjust = 1,color = 'black'),
    #axis.title.x = element_text(size=14,margin = margin(t = 5, b = 0)),
    axis.title.x = element_blank(),
    axis.title.y = element_text(size=16,margin = margin(r = 2)))
# Add p-values comparing groups
# Specify the comparisons you want
my_comparisons <- list( c("Crack (+), plant (+)", "Crack (-), plant (+)") )
p2 <- p2 + stat_compare_means(ref.group = "Crack (-), plant (-)", label = "p.signif",
                              method = "t.test",size=8,label.y = 20) 
# p2<- p2+stat_compare_means(label.y = 20)
p2
ggsave(p2,filename = "Fig2p2Hardness.pdf",width = 5,height = 4)

# ==================statistical analysis============== 

# res <- wilcox.test(Treatments ~ Hardness, data = CrackPlant, paired = TRUE)
CrackPlant$Group=seq(1,48,by=1)
Lab1<- unique(CrackPlant$Treatments)
for (i in 1:length(Lab1)){
  CrackPlant$Group[CrackPlant$Treatments==Lab1[i]]=toString(Lab1[i])
}
dataHard$Hardness<- unlist(CrackPlant$Hardness) 
dataHard$Salinity<- unlist(CrackPlant$Salinity)
dataHard$water<- unlist(CrackPlant$water)

res.aov <- aov(Hardness ~ Group, data = dataHard)
summary(res.aov)
TukeyHSD(res.aov)
pairwise.t.test(dataHard$Hardness, dataHard$Group,
                p.adjust.method = "BH", pool.sd = FALSE)

############################ p3: Salinity ############################
p3 <- ggbarplot(CrackPlant, x = "Treatments", y = "Salinity", add = "mean_se",
                color = "Treatments", fill = "Treatments", alpha = 0.5, palette = "jco",
                xlab = "Treatments", ylab = "Salinity (ppt)" ) + 
  scale_x_discrete(labels=c("Crack (+), plant (+)" = "Crack (+),\nPlant (+)",
                            "Crack (-), plant (+)" = "Crack (-),\nPlant (+)",
                            "Crack (-), plant (-)" = "Crack (-),\nPlant (-)",
                            "Crack (+), plant (-)" = "Crack (+),\nPlant (-)")) +
  theme_bw() +
  theme(
    panel.border = element_rect(size = 1.0,colour = "black", linetype=1),
    axis.line=element_line(size = 0.6, colour = "black", linetype=1),
    legend.position = "none",#c(0.2,0.8),
    legend.title = element_blank(),
    legend.text = element_text(size = 14,color = "black"),
    legend.background = element_rect(fill = NA,color = NA),
    axis.text.x = element_text(size=16, vjust = 0.5,hjust=0.5,color = 'black'),
    axis.text.y = element_text(size=16, hjust = 1,color = 'black'),
    #axis.title.x = element_text(size=14,margin = margin(t = 5, b = 0)),
    axis.title.x = element_blank(),
    axis.title.y = element_text(size=16,margin = margin(r = 2)))
# Add p-values comparing groups
# Specify the comparisons you want
my_comparisons <- list( c("Crack (+), plant (+)", "Crack (-), plant (+)") )
p3 <- p3 + stat_compare_means(ref.group = "Crack (-), plant (-)", label = "p.signif",
                              method = "t.test",size=8,label.y = 3.5) 
p3
ggsave(p3,filename = "Fig2p3Salinity.pdf",width = 5,height = 4)


res.aov2 <- aov(Salinity ~ Group, data = dataHard)
summary(res.aov2)
TukeyHSD(res.aov2)

############################ p4: Water_content ############################
p4 <- ggbarplot(CrackPlant, x = "Treatments", y = "water", add = "mean_se",
                color = "Treatments", fill = "Treatments", alpha = 0.5, palette = "jco",
                xlab = "Treatments", ylab = "Water content (%)" ) + 
  scale_x_discrete(labels=c("Crack (+), plant (+)" = "Crack (+),\nPlant (+)",
                            "Crack (-), plant (+)" = "Crack (-),\nPlant (+)",
                            "Crack (-), plant (-)" = "Crack (-),\nPlant (-)",
                            "Crack (+), plant (-)" = "Crack (+),\nPlant (-)")) +
  ylim(0,25)+
  theme_bw() +
  theme(
    panel.border = element_rect(size = 1.0,colour = "black", linetype=1),
    axis.line=element_line(size = 0.6, colour = "black", linetype=1),
    legend.position = "none",#c(0.2,0.8),
    legend.title = element_blank(),
    legend.text = element_text(size = 14,color = "black"),
    legend.background = element_rect(fill = NA,color = NA),
    axis.text.x = element_text(size=16, vjust = 0.5,hjust=0.5,color = 'black'),
    axis.text.y = element_text(size=16, hjust = 1,color = 'black'),
    #axis.title.x = element_text(size=14,margin = margin(t = 5, b = 0)),
    axis.title.x = element_blank(),
    axis.title.y = element_text(size=16,margin = margin(r = 2)))
# Add p-values comparing groups
p4 <- p4 + stat_compare_means(ref.group = "Crack (-), plant (-)", label = "p.signif", 
                              method = "t.test", size=8, label.y = 23) 
p4
ggsave(p4,filename = "Fig2p4Water_content.pdf",width = 5,height = 4)

res.aov3 <- aov(water ~ Group, data = dataHard)
summary(res.aov3)
TukeyHSD(res.aov3)

############################ p5: Crack width ############################
p5 <- ggbarplot(CrackPlant, x = "Treatments", y = "Crack_width", add = "mean_se",
                color = "Treatments", fill = "Treatments", alpha = 0.1, palette = "jco",
                xlab = "Treatments", ylab = "Crack width (cm)" ) + 
  scale_x_discrete(labels=c("Crack (+), plant (+)" = "Crack (+),\nPlant (+)",
                            "Crack (-), plant (+)" = "Crack (-),\nPlant (+)",
                            "Crack (-), plant (-)" = "Crack (-),\nPlant (-)",
                            "Crack (+), plant (-)" = "Crack (+),\nPlant (-)")) +
  theme_bw() +
  theme(
    panel.border = element_rect(size = 1.0,colour = "black", linetype=1),
    axis.line=element_line(size = 0.6, colour = "black", linetype=1),
    legend.position = "none",#c(0.2,0.8),
    legend.title = element_blank(),
    legend.text = element_text(size = 14,color = "black"),
    legend.background = element_rect(fill = NA,color = NA),
    axis.text.x = element_text(size=14, vjust = 0.5,hjust=0.5,color = 'black'),
    axis.text.y = element_text(size=14, hjust = 1,color = 'black'),
    #axis.title.x = element_text(size=14,margin = margin(t = 5, b = 0)),
    axis.title.x = element_blank(),
    axis.title.y = element_text(size=14,margin = margin(r = 2)))
# Add p-values comparing groups
p5 <- p5 + stat_compare_means(ref.group = "Crack (-), plant (-)", label = "p.signif", method = "t.test") 
p5
ggsave(p5,filename = "Fig2p5Crack_width.pdf",width = 5,height = 4)


