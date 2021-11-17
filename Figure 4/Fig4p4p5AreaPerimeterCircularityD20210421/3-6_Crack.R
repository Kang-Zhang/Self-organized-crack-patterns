### NO. of plants of each patch
library(ggplot2)
library(ggExtra)
library(readxl)
## ÔØÈëÊı¾İ
CrackPlant <- read_excel("3-6.xls", 'Crack')
# CrackPlant
head(CrackPlant)
#CrackPlant = CrackPlant[which(CrackPlant$Perimeter<200),]
# classic plot :
PixelSize=0.03443
p <- ggplot(CrackPlant, aes(x=Length*PixelSize, y=Direction, color=Direction)) +
     geom_point(size=3) +
     labs(x = "Length", y = "Direction")+
     theme_bw()+
     theme(
          panel.border = element_rect(size = 1.0,colour = "black", linetype=1),
          # axis.line=element_line(size = 0.6, colour = "black", linetype=1),
          #legend.position="left",
           legend.position=c(0.86, 0.21),
          # legend.title = element_blank(), # element_blank()
          legend.title = element_text(size = 10,color = "black"),
          legend.text = element_text(size = 10,color = "black"),
          legend.background = element_rect(fill = NA,color = NA),
          legend.key=element_rect(fill='NA'),
          axis.text.x = element_text(size=14, vjust = 0.5,hjust=0.5,color = 'black', angle=0),
          axis.text.y = element_text(size=14, hjust = 1,color = 'black'),
          axis.title.x = element_text(size=14,margin = margin(t = 5, b = 0)),
          axis.title.y = element_text(size=14,margin = margin(r = 2)))

# with marginal histogram
p1 <- ggMarginal(p, type="histogram")
p1
# marginal density
#p2 <- ggMarginal(p, type="density")
#p2
# marginal boxplot
#p3 <- ggMarginal(p, type="boxplot")
#p3

# Set relative size of marginal plots (main plot 10x bigger than marginals)
#p4 <- ggMarginal(p, type="histogram", size=10)
#p4
# Custom marginal plots:
#p5 <- ggMarginal(p, type="histogram", fill = "slateblue", xparams = list(  bins=10))
#p5
# Show only marginal plot for x axis
#p6 <- ggMarginal(p, margins = 'x', color="purple", size=4)
#p6

ggsave(p1,filename = "3-6_Crack.pdf",width = 5,height = 5)
#ggsave(p2,filename = "Sheet1p2.pdf",width = 5,height = 4)
#ggsave(p3,filename = "Sheet1p3.pdf",width = 5,height = 4)
#ggsave(p4,filename = "Sheet1p4.pdf",width = 5,height = 4)
#ggsave(p5,filename = "Sheet1p5.pdf",width = 5,height = 4)
#ggsave(p6,filename = "Sheet1p6.pdf",width = 5,height = 4)
