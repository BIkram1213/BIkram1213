# R_code_ecosystem_functions.r

# R code to view biomass over the world and calculate changes in ecosystem functions
# energy
# chemical cycling
# proxies

# install.packages("rasterdiv")
# install.packages("rasterVis")

library(rasterVis)
library(rasterdiv)

data(copNDVI)
plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
levelplot(copNDVI)

copNDVI10 <- aggregate(copNDVI, fact=10)
levelplot(copNDVI10)

copNDVI100 <- aggregate(copNDVI, fact=100)
levelplot(copNDVI100)

####################################

# library(ggplot2)

# myPalette <- colorRampPalette(c('white','green','dark green'))
# sc <- scale_colour_gradientn(colours = myPalette(100), limits=c(1, 8))

# ggR(copNDVI, geom_raster = TRUE) +
# scale_fill_gradientn(name = "NDVI", colours = myPalette(100))+
# labs(x="Longitude",y="Latitude", fill="")+
#   theme(legend.position = "bottom") +
#  NULL


setwd("~/lab/")

# setwd("C:/lab/") # windows

library(raster)

defor1 <- brick("defor1_.jpg") 
defor2 <- brick("defor2_.jpg") 

# band1: NIR, defor1_.1
# band2: red, defor1_.2
# band3: green

plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

dvi1 <- defor1$defor1_.1 - defor1$defor1_.2 

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

hist(difdvi)
