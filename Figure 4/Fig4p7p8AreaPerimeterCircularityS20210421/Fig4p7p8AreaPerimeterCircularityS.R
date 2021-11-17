### NO. of plants of each patch
library(ggplot2)
library(ggExtra)
library(readxl)
library(latex2exp)
library(RColorBrewer)
##############################################################################
#############################
# fit the logarithmic model #
#############################
logarithm.fn = function(Area,Perimeter)
{# model: s=c+z*log(n)
  lm.out = lm(Perimeter~log(Area))
  prd.s  = predict(lm.out)
  return(prd.s=prd.s) 
}
#######################
# fit the power model #
#######################
power.fn=function(Area,Perimeter)
{# model: s=c+z*log(n)
  nls.out = nls(Perimeter~b*Area^z,start=c(b=10,z=0.5))
  prd.s   = predict(nls.out)
  return(prd.s=prd.s) 
}
##########################
# fit the logistic model #
##########################
logist.fn=function(Area,Perimeter)
{# model: s=c+z*log(n)
  nls.out = nls(Perimeter~b/(a+Area^(-z)),start=c(b=10,a=0.1,z=0.5))
  prd.s   = predict(nls.out)
  return(prd.s=prd.s)
}
##############################################################################
## ????????
#CrackPlant <- read_excel("Watervectorlmage.xlsx", 'Sheet1')
CrackPlant <- read_excel("Watervectorlmage.xlsx", 'Sheet1')

# CrackPlant
head(CrackPlant)
CrackPlant = CrackPlant[which(CrackPlant$Perimeter<200),]

# classic plot :
PixelSize=0.03443
CrackPlant$Area = CrackPlant$Area*PixelSize
CrackPlant$Perimeter = CrackPlant$Perimeter*PixelSize

#???????Ϻ???
prd.log.s=logarithm.fn(CrackPlant$Area,CrackPlant$Perimeter)
prd.power.s=power.fn(CrackPlant$Area,CrackPlant$Perimeter)
prd.logist.s=logist.fn(CrackPlant$Area,CrackPlant$Perimeter)
#?????Ͻ????ϲ?
CrackPlant$prd.log.s = prd.log.s
CrackPlant$prd.power.s = prd.power.s
CrackPlant$prd.logist.s = prd.logist.s
#############################################
#p1 Fig4p7AreaPerimeterS #
#############################################
nls.out = nls(Perimeter~b*Area^z,start=c(b=0.69,z=0.5), data=CrackPlant)
summary(nls.out)
FS=16

mycolors <- rev(brewer.pal(20,"RdYlBu"))
mybreaks=c(0.3,0.7,1.0)
p <- ggplot(CrackPlant, aes(x=Area, y=Perimeter, alpha=1,color=Circularity)) +
  geom_point(size=4) +
  scale_x_log10(limits = c(4, 100.0),breaks=c(4,10,30, 100)) +
  scale_y_log10(limits = c(1, 10.0)) +
  annotation_logticks(sides = "bl")+
  #geom_line(data=cordata,aes(Area,prd.log.s),colour = "blue") +
  geom_line(aes(Area,prd.power.s),colour = "black",lt=2) +
  #geom_line(data=cordata,aes(Area,prd.logist.s),colour = "red") +
  labs(x = TeX('$Area\\,(m^2)$'), y = TeX('$Perimeter\\,(m)$'))+
  annotate("text", x=8, y=5, label=TeX("$y = 0.82x^{0.50}$", output="character"),
           hjust=0, size = 6, parse = TRUE)+
  scale_color_gradientn(colours = mycolors,name=expression('circularity'),
                        breaks=mybreaks,limits = c(0.3, 1.0),
                        guide = guide_colourbar(direction = "vertical",
                                                barwidth = 0.8, barheight = 6))+
  scale_alpha(guide=FALSE)+
  theme_bw()+
theme(
   panel.border = element_rect(size = 1.0,colour = "black", linetype=1),
  # axis.line=element_line(size = 0.6, colour = "black", linetype=1),
  # legend.position="none",
   legend.position=c(0.85, 0.3),
  # legend.title = element_blank(), # element_blank()
   legend.title = element_text(size = FS,color = "black"),
   legend.text = element_text(size = FS,color = "black"),
   legend.background = element_rect(fill = NA,color = NA),
   legend.key=element_rect(fill='NA'),
  axis.text.x = element_text(size=18, vjust = 0.5,hjust=0.5,color = 'black', angle=0),
  axis.text.y = element_text(size=18, hjust = 1,color = 'black'),
  axis.title.x = element_text(size=18,margin = margin(t = 5, b = 0)),
  axis.title.y = element_text(size=18,margin = margin(r = 2)))
# with marginal histogram
p1 <- ggMarginal(p, type="histogram")
p1
ggsave(p1,filename = "Fig4p7AreaPerimeterS.pdf",width = 5,height = 5)


#############################################
#pp1 Fig4p8AreCircularityS #
#############################################
mybreaks=c(2,5,8)
pp <- ggplot(CrackPlant, aes(x=Area, y=Circularity,alpha=0.6, color=Perimeter)) +
  geom_point(size=4) +
  #scale_x_log10() +
  #scale_y_log10() +
  labs(x = TeX('$Area\\,(m^2)$'), y = TeX('$Circularity$'))+
  scale_color_gradientn(colours = mycolors,name=expression(''),
                        breaks=mybreaks,limits = c(2, 8.0),
                        guide = guide_colourbar(direction = "horizontal",
                                                barwidth = 10, barheight = 0.8))+
  scale_x_continuous(limits=c(0,80), breaks=c(0,20,40,60,80))+
  scale_y_continuous(limits=c(0.2,1.0), breaks=c(0.2,0.4,0.6,0.8,1.0))+
  scale_alpha(guide=FALSE)+
  theme_bw()+
  theme(
    panel.border = element_rect(size = 1.0,colour = "black", linetype=1),
    # axis.line=element_line(size = 0.6, colour = "black", linetype=1),
    # legend.position="none",
    legend.position=c(0.6, 0.1),
    # legend.title = element_blank(), # element_blank()
    legend.title = element_text(size = FS,color = "black"),
    legend.text = element_text(size = FS,color = "black"),
    legend.background = element_rect(fill = NA,color = NA),
    legend.key=element_rect(fill='NA'),
    axis.text.x = element_text(size=18, vjust = 0.5,hjust=1,color = 'black', angle=0),
    axis.text.y = element_text(size=18, hjust = 1,color = 'black'),
    axis.title.x = element_text(size=18,margin = margin(t = 5, b = 0)),
    axis.title.y = element_text(size=18,margin = margin(r = 2)))

# with marginal histogram
pp1 <- ggMarginal(pp, type="density")
pp1
ggsave(pp1,filename = "Fig4p8AreCircularityS.pdf",width = 5,height = 5)

