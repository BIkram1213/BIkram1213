setwd("C:/lab/")
raster
install.packages ("raster")
install.packages ("RStoolbox")


library(raster)
library(RStoolbox)

# brick to import the whole image of the satellite. 
p224r63_2011 <- brick("p224r63_2011_masked.grd")

#b1 blue
#b2 green
#b3 red
#b4 NIR
#b5 SWIR (short-wave infrared)
#b6 thermal infrared 
#b7 SWIR
#b8 panchromatic

# plot the image in the RGB 
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin") # linear stretch

# plot this data by ggplot2 
library(ggplot2)
ggRGB(p224r63_2011,5,4,3)
# same image

# let's do the same with the 1988 image 
p224r63_1988 <- brick("p224r63_1988_masked.grd")
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")

# put the images together
par(mfrow=c(1,2)) 
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")
 
# name of the bands 
names(p224r63_2011)
#"B1_sre" "B2_sre" "B3_sre" "B4_sre" "B5_sre" "B6_bt"  "B7_sre"

# $ links the bands to the whole image 
plot(p224r63_2011$B1_sre, p224r63_2011$B3_sre)

# reduce the resolution, > aggregate function, we are decreasing with a factor 10 
p224r63_2011_res <- aggregate(p224r63_2011, fact=10)


p224r63_2011_pca <- rasterPCA(p224r63_2011_res)

plot(p224r63_2011_pca$map)
# $ is linking all the different pieces of the output, call, model and map 

# let's change the colors
cl <- colorRampPalette(c("dark grey","grey","light grey"))(100)
plot(p224r63_2011_pca$map, col=cl)

# info about the model 
summary(p224r63_2011_pca$model)


pairs(p224r63_2011)
# to see the amount of correlation between the different data 

# now we can plot the first 3 components for example, with plotRGB
plotRGB(p224r63_2011_pca$map, r=1, g=2, b=3, stretch="Lin")

# let's do the same for the 1988 
p224r63_1988_res <- aggregate(p224r63_1988, fact=10)
p224r63_1988_pca <- rasterPCA(p224r63_1988_res)
plot(p224r63_1988_pca$map, col=cl)

summary(p224r63_1988_pca$model) # we see that there is high correlation 
pairs(p224r63_1988)

# now we can make a difference between the 1988 and 2011 and then plotting the difference. 
difpca <- p224r63_2011_pca$map - p224r63_1988_pca$map
plot(difpca)


cldif <- colorRampPalette(c('blue','black','yellow'))(100)
plot(difpca$PC1, col=cldif)

