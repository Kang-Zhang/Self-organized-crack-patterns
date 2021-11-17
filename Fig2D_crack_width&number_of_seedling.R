### Seed germination in the crack

#install.packages("readxl")
## packages
library(ggplot2)
library(hrbrthemes)
library(readxl)

## import data
CrackPlant <- read_excel("Spatial self-organization in the Yellow River Delta-jiaguo Yan & Johan Van de Koppel 20180404.xlsx", 'Seed germination in the crack')
# CrackPlant

# linear trend + confidence interval
p3 <- ggplot(CrackPlant, aes(x=Crack_width, y=NO._of_seedling)) +
  geom_point() +
  geom_smooth(method=lm , color="red", fill="#69b3a2", se=TRUE) +
  labs(x = "Crack width (cm)", y = "Number of seedling (ind.)")+
  theme_bw() +
  theme(
    panel.border = element_rect(size = 1.0,colour = "black", linetype=1),
    axis.line=element_line(size = 0.6, colour = "black", linetype=1),
    # axis.line=element_line(size = 0.6, colour = "black", linetype=1),
    # legend.position=c(0.25,0.82),
    legend.title = element_blank(), # element_blank()
    legend.text = element_text(size = 14,color = "black"),
    legend.background = element_rect(fill = NA,color = NA),
    # legend.key=element_rect(fill='NA'),
    axis.text.x = element_text(size=14, vjust = 0.5,hjust=0.5,color = 'black', angle=0),
    axis.text.y = element_text(size=14, hjust = 1,color = 'black'),
    axis.title.x = element_text(size=14,margin = margin(t = 5, b = 0)),
    axis.title.y = element_text(size=14,margin = margin(r = 2)))
p3
ggsave(p3,filename = "Fig1p3.pdf",width = 5,height = 4)




library("ggpubr")
p5 <- ggscatter(CrackPlant, x = "Crack_width", y = "NO._of_seedling", 
          add = "reg.line", conf.int = TRUE, 
          add.params = list(color = "blue",
                            fill = "#69b3a2"),
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Crack width (cm)", ylab = "Number of seedling (ind.)")
p5
ggsave(p5,filename = "Fig1p5.pdf",width = 5,height = 4)


# statistcal analysis for main text
# The significance value for this correlation coefficient is less than .05
cor.test(CrackPlant$NO._of_seedling, CrackPlant$Crack_width, method = "spearman")
#  conclusion
# There was a significant postive relationship between the number of seedling and the
# crack width, r = .93, p (one-tailed) < .001.

# cor.test(CrackPlant$NO._of_seedling, CrackPlant$Crack_width)

newModel<-lm(NO._of_seedling ~ Crack_width, data = CrackPlant)
summary(newModel)
