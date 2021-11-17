### Plants impact on crack
library(dplyr)
library(scales)
library(readxl)
library(reshape2)
library(ggplot2)
## import data
CrackPlant <- read_excel("Spatial self-organization in the Yellow River Delta-jiaguo Yan & Johan Van de Koppel 20180404.xlsx", 'Plants impact on crack')
head(CrackPlant)
# melt
df <- melt(CrackPlant, id="Crack_width", variable.name="Attribute", value.name = "Size")
df$Crack_width= factor(df$Crack_width, levels=c('Plants in high density',
                                               'Plants in medium density', 
                                               'Plants removal')) 

mean   <- aggregate(df$Size, by=list(df$Crack_width, df$Attribute), FUN=mean)
sd     <- aggregate(df$Size, by=list(df$Crack_width, df$Attribute), FUN=sd)
len    <- aggregate(df$Size, by=list(df$Crack_width, df$Attribute), FUN=length)
df_res <- data.frame(mean, sd=sd$x, len=len$x)
colnames(df_res) = c("Crack_width", "Attribute", "Mean", "Sd", "Count")
#str(df_res)
df_res$Se <- df_res$Sd/sqrt(df_res$Count) 
#df_res 

# Make the plot
p1 = ggplot(data=df_res, aes(x=Attribute, y=Mean, ymin=Mean-Se, ymax=Mean+Se, 
                             fill=Crack_width, linetype=Crack_width, group=Crack_width)) + 
  geom_line() + 
  geom_ribbon(alpha=0.6) + 
  geom_point(size=0.8) +
  geom_errorbar(width = 0.1, linetype='solid') +
  geom_text(size=5, aes(x=2, y=1.2, label = c("n = 10"))) +
  xlab("Time") + 
  ylab("Crack width (cm)") + 
  scale_x_discrete(labels=c("42170" = "08-May", "42199" = "14-May","42231" = "30-May",
                            "42264" = "15-Jun","42291" = "15-Jun","42363" = "15-Jul",
                            "42384" = "17-Sep"))+
  
  theme_bw()+
  theme(
    panel.border = element_rect(size = 1.0,colour = "black", linetype=1),
    axis.line=element_line(size = 0.6, colour = "black", linetype=1),
    legend.position=c(.36,.86),
    legend.title = element_blank(), # element_blank()
    legend.text = element_text(size = 14,color = "black"),
    legend.background = element_rect(fill = NA,color = NA),
    #legend.key=element_rect(fill='NA'),
    axis.text.x = element_text(size=14, hjust=0.5,color = 'black', vjust = 0.5, angle=20),
    axis.text.y = element_text(size=14, hjust = 1, color = 'black'),
    #axis.title.x = element_text(size=14, margin = margin(t = 5, b = 0)),
    axis.title.x = element_blank(),
    axis.title.y = element_text(size=14, margin = margin(r = 2)))

p1
ggsave(p1,filename = "Fig5CrackWidth_Time.pdf",width = 5,height = 4)

# ggline(df, x = "Attribute", y = "Size", add = c("mean_se","jitter"),
#        color = "Crack_width", palette = "jco")

# ggboxplot(df, x = "Attribute", y = "Size",
#           color = "Crack_width", palette = "jco",
#           add = "jitter")
