# R code for Multivirate analysis
setwd("C:/lab/")
biomes<-read.table("biomes.csv", header=T,sep=",")
head(bomes) # view (biomes)
# DEtrended CORrespondence ANAlysis
multivar <- decorana(biomes)
multivar

plot(multivar)

# biomes types
biomes_types <- read.table("biomes_types.csv", header=T, sep=",")
head(biomes_types)

attach(biomes_types)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind = "ehull", lwd=3)
# or col=1:4

ordispider(multivar, type, col=c("black","red","green","blue"), label = T) 
