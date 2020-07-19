# R code to view biomass over the world and calculate changes in ecosystem function
# energy
# chemical cycling
# proxies

install.packages("rasterdiv")
install.packages("rasterVis")

library(rasterVis)
library(rasterdiv)

data(copNDVI) # global NDVI data
plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
# reclassify the data to remove water values
levelplot(copNDVI)

copNDVI10 <- aggregate(copNDVI, fact=10)
# smoothen the map with lower resolution
levelplot(copNDVI10)

copNDVI100 <- aggregate(copNDVI, fact=100)
# high rescolution, not good quality image at this scale
levelplot(copNDVI100)


setwd("C:/lab/")

library(raster)

defor1 <- brick("defor1_.jpg") 
defor2 <- brick("defor2_.jpg") 

# band1: NIR, defor1_.1
# band2: red, defor1_.2
# band3: green

plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")
# RGB put the Red Green Blue plot of multi layerd raster
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

dvi1 <- defor1$defor1_.1 - defor1$defor1_.2 # plots the difference between the two image

# defor2
# band1: NIR, defor2_.1
# band2: red, defor2_.2

dvi2 <- defor2$defor2_.1 - defor2$defor2_.2 

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
par(mfrow=c(1,2))
plot(dvi1, col=cl)
plot(dvi2, col=cl)

difdvi <- dvi1 - dvi2

cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)
#we can see where we have lost the forests, loss of ecosystem functions (red parts = loss in biomass and related services)

hist(difdvi) # to plot histogram

#see the difference in ecosystem in different time scale via image and colour bands
