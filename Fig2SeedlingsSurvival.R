### Crack impacts on plant survival
library(readxl)
library(dplyr)
library(reshape2)
library(ggplot2)
## import data
CrackPlant <- read_excel("Spatial self-organization in the Yellow River Delta-jiaguo Yan & Johan Van de Koppel 20180404.xlsx", 'Crack impacts on plant survival')
#head(CrackPlant)
# melt
df <- melt(CrackPlant, id = "Treatments", variable.name = "Attribute", value.name = "Size")
df$Treatments = factor(df$Treatments, levels=c('Transplant control', 'Crack control',
                                             'Crack compacted', 'Intermediate', 'Patch center')) 

mean   <- aggregate(df$Size, by=list(df$Treatments, df$Attribute), FUN=mean)
sd     <- aggregate(df$Size, by=list(df$Treatments, df$Attribute), FUN=sd)
len    <- aggregate(df$Size, by=list(df$Treatments, df$Attribute), FUN=length)
df_res <- data.frame(mean, sd=sd$x, len=len$x)
colnames(df_res) = c("Treatments", "Attribute", "Mean", "Sd", "Count")
#str(df_res)
df_res$Se <- df_res$Sd/sqrt(df_res$Count) 
#df_res 

# Make the plot
p1 = ggplot(data=df_res, aes(x=Attribute, y=Mean, ymin=Mean-Se, ymax=Mean+Se, 
                             fill=Treatments, linetype=Treatments, group=Treatments)) + 
  geom_line() + 
  geom_ribbon(alpha=0.6) + 
  geom_point(size=0.8) +
  geom_errorbar(width = 0.1, linetype='solid') +
  # geom_text(size=5, aes(x=5, y=10, label = c("n = 10"))) +
  labs(x = "Time", y = "Seedlings survival (ind.)")+
  scale_x_discrete(labels=c("42132" = "08-May", "42138" = "14-May", "42154" = "30-May",
                            "42170" = "15-Jun", "42200" = "15-Jul", "42264" = "17-Sep")) +
  #scale_linetype_discrete(guide=FALSE)+
  theme_bw()+
  theme(
    panel.border = element_rect(size = 1.0,colour = "black", linetype=1),
    axis.line=element_line(size = 0.6, colour = "black", linetype=1),
    #legend.position="none",
    legend.position = c(.76,.8),
    legend.title = element_blank(),
    legend.text = element_text(size = 14,color = "black"),
    legend.background = element_rect(fill = NA,color = NA),
    #legend.key=element_rect(fill='NA'),
    axis.text.x = element_text(size=14, vjust = 0.5,hjust = 0.5,color = 'black', angle=20),
    axis.text.y = element_text(size=14, hjust = 1,color = 'black'),
    # axis.title.x = element_text(size=14,margin = margin(t = 5, b = 0)),
    axis.title.x = element_blank(),
    axis.title.y = element_text(size=14,margin = margin(r = 2)))
  #scale_fill_discrete(name="Experimental\nCondition",
  #                    breaks=c("Crack compacted", "Crack control", "Intermediate",
  #                             "Patch center", "Transplant control"),
  #                    labels=c("Crack compacted", "Crack control", "Intermediate", 
  #                             "Patch center", "Transplant control"))
p1
ggsave(p1,filename = "Fig4SeedlingsSurvival.pdf",width = 5,height = 4)

#ggline(df, x = "Attribute", y = "Size", add = c("mean_se","jitter"),
#       color = "Treatments", palette = "jco")

#ggboxplot(df, x = "Attribute", y = "Size",
#          color = "Treatments", palette = "jco",
#          add = "jitter")
