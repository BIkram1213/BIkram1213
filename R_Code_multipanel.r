### Multipanel in R
install.packages("GGally") # used for gg pairs()
library("sp") #require(sp) same
library(GGally)

data(meuse)
attach(meuse
#make all the possible pairwise plot of the dataset
pairs(meuse)
pairs(~cadmium+copper+lead+zinc,data=meuse)
pairs(meuse[,3:6])
pairs(meuse[,3:6], col="red",pch=21,cex=2)
#GGally for beautification
ggpairs(meuse[,3:6])
ggpairs(meuse[,3:6], col="red")
