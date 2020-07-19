setwd("C:/lab/") 
library(raster)
p224r63_2011 <- brick("p224r63_2011_masked.grd") 
# brick imports the image
plot(p224r63_2011)

cl <- colorRampPalette(c('black','grey','light grey'))(100)
# turns the image to greyscale
plot(p224r63_2011, col=cl)
# now lets put colour
# Color bands
# B1: blue
# B2: green
# B3: red
# B4: NIR(near infrared)
par(mfrow=c(2,2))
# mfrow sets the rows and coloumns
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) 
# lets put different coulour for different bands
plot(p224r63_2011$B1_sre, col=clb)
# $ is used to link symbols
clg <- colorRampPalette(c('dark green','green','light green'))(100) 
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c('dark red','red','pink'))(100) 
plot(p224r63_2011$B3_sre, col=clr)

cln <- colorRampPalette(c('red','orange','yellow'))(100) # NIR
plot(p224r63_2011$B4_sre, col=cln)
# all the images one 
par ( mfrow = c ( 4 , 1 ))

# Close all the graphs
dev.off ()


# RGB 
# plotRGB, with linear stretching
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
# now we are making all the components shift and add first the NIR
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

# Exercise: mount NIR ontop the G of RGB

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #NIR on top of the green component of the RGB
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin") #NIR on top of the blue component of the RGB


# 1988 image
# p224r63_1988_masked

p224r63_1988 <- brick("p224r63_1988_masked.grd")
plot ( p224r63_1988 )

# exercise plot in rgb both images
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
# we can see the two images together so we can appreciate the changes, vegatation is difficult to see
# show the same plot but with 432 RGBspace, to see the NIR 
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist") #histogram stretch
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

# DVI for the two years: compare with a difference in time
# NIR - RED
# NDVI = (NIR - RED) / (NIR - RED)
# we are going to use the vegetation index
dvi2011 <- (p224r63_2011$B4_sre - p224r63_2011$B3_sre)
cl <- colorRampPalette(c("purple", "light blue", "pink"))(100)
plot(dvi2011, col=cl)

# excersise: dvi for 1988
dvi1988 <- (p224r63_1988$B4_sre - p224r63_1988$B3_sre)
cl <- colorRampPalette(c("purple", "light blue", "pink"))(100)
plot(dvi1988, col=cl)

# difference from one year to the other
diff <- dvi2011 - dvi1988
plot(diff)

# lets change the grain size (dimension of the pixels) 
# aggregate function, aggregates pixels to make a coarser grain, increase of the pixels.
# this process is called resampling 
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res100 <- aggregate(p224r63_2011, fact=100)

# now we plot 
par(mfrow=c(3,1))

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch="Lin")

# 

