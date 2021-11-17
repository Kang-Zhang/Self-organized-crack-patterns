### Biomass
## packages
library(readxl)
library(reshape2)

## import data
CrackPlant <- read_excel("Spatial self-organization in the Yellow River Delta-jiaguo Yan & Johan Van de Koppel 20180404.xlsx", 'Full Factorial experiment')
CrackPlant <- CrackPlant[which(CrackPlant$Density != 0),]
#CrackPlant <- CrackPlant[which(CrackPlant$Treatments == 'Crack (+), plant (+)'),]
CrackPlant <- select(CrackPlant, Treatments, Above_ground_biomass, Below_ground_biomass, Biomass)#, Crack_width, Hardness, Salinity, water)

CrackPlant$Treatments = factor(CrackPlant$Treatments, levels=c('Crack (+), plant (+)','Crack (-), plant (+)')) 
df <- melt(CrackPlant, id="Treatments", variable.name = "Attribute", value.name = "Size")
df$Attribute = factor(df$Attribute, levels=c('Biomass', 'Above_ground_biomass', 'Below_ground_biomass')) 

############################ p: Biomass ############################
library(tidyverse)
df<- df %>% filter(!is.na(df$Attribute))

p <- ggbarplot(df, x = "Attribute", y = "Size", add = "mean_se",
               color = "Treatments", fill = "Treatments", alpha = 0.5, palette = "jco", add = "jitter",
               xlab = "Treatments", ylab = "Biomass (Dw g)",
               position = position_dodge(0.8)) + 
  scale_x_discrete(labels=c("Biomass" = "Biomass",
                            "Above_ground_biomass" = "Above ground \nbiomass",
                            "Below_ground_biomass" = "Below ground \nbiomass")) +
  ylim(0,25)+
  theme_bw() +
  theme(
    panel.border = element_rect(size = 1.0,colour = "black", linetype=1),
    axis.line=element_line(size = 0.6, colour = "black", linetype=1),
    legend.position = c(0.75,0.85),#"none",#
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
#my_comparisons <- list( c("Crack (+), plant (+)", "Crack (-), plant (+)") )
p <- p + stat_compare_means(aes(group = Treatments), label = "p.signif",size=8, 
                            label.y = 20, method = "t.test") +
  scale_color_discrete(breaks=c("Crack (+), plant (+)", "Crack (-), plant (+)"),
                       labels=c("Plant (+), Crack (+)", "Plant (+), Crack (-)")) +
  scale_fill_discrete(breaks=c("Crack (+), plant (+)", "Crack (-), plant (+)"),
                      labels=c("Plant (+), Crack (+)", "Plant (+), Crack (-)"))
p
ggsave(p,filename = "Fig3p_Biomass.pdf",width = 5,height = 4)

#Add P-values and Significance Levels to ggplots
compare_means(Size ~ Treatments, data = df, 
              group.by = "Attribute", method = "anova") # "t.test"、"anova"、"kruskal.test"

res.aov3 <- aov(Size ~ Treatments, data = df)
summary(res.aov3)

