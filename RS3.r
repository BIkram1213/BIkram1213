setwd("C:/lab/")
raster
# install.packages ("raster")
# install.packages ("RStoolbox")


library ( raster )

# import the images of the lab folder
p224r63_2011  <- brick ( " p224r63_2011_masked.grd " )
# path = pr = row to find the satellite image uniquely

plot ( p224r63_2011 ) # each band has a meaning, 1 = blue, 2 = green, 3 = red, 4 = near infrared, 5 = middle infrared, 6 = termal infrared 7 = middle infrared

# Bands
# B1 blue
# B2 green
# B3 red
# B4 near infrared

cl  <- colorRampPalette (c ( ' black ' , ' gray ' , ' light gray ' )) ( 100 ) # change the color of the image
plot ( p224r63_2011 , col = cl )

# multiframe of different plots
par ( mfrow = c ( 2 , 2 )) # to have several layers together. In brackets 2 rows for two columns
# use 2.2 because in the end I will use 4 bands
# B1
clb  <- colorRampPalette (c ( ' dark blue ' , ' blue ' , ' light blue ' )) ( 100 )
plot ( p224r63_2011 $ B1_sre , col = clb ) # the dollar connects the image to the blue band b1

# B2
clg  <- colorRampPalette (c ( ' dark green ' , ' green ' , ' light green ' )) ( 100 )
plot ( p224r63_2011 $ B2_sre , col = clg )

# if I close the graph window the par command does not work and I have to call it back

# B3
clr  <- colorRampPalette (c ( ' dark red ' , ' red ' , ' pink ' )) ( 100 )
plot ( p224r63_2011 $ B3_sre , col = clr )

# B4
cln  <- colorRampPalette (c ( ' red ' , ' orange ' , ' yellow ' )) ( 100 )
plot ( p224r63_2011 $ B4_sre , col = cln )


# if I want all the images one below the other I have to write
par ( mfrow = c ( 4 , 1 ))

# I close all the graphs
dev.off ()

# RGB to see with a human eye
plotRGB ( p224r63_2011 , r = 3 , g = 2 , b = 1 , stretch = " Lin " ) # stretch stretches the colors as much as you can
# Lin must be written in capital letters

# to make the vegetation more visible I use near infrared (I know that the leaves reflect that length well)

# since I can only use 3 bands I eliminate blue

plotRGB ( p224r63_2011 , r = 4 , g = 3 , b = 2 , stretch = " Lin " )

# this turns all near infrared red

# ex nir on the top of the G component

plotRGB ( p224r63_2011 , r = 3 , g = 4 , b = 2 , stretch = " Lin " )

# and finally in the b component
plotRGB ( p224r63_2011 , r = 3 , g = 2 , b = 4 , stretch = " Lin " )

# comparison between 2011 and 1988

library ( raster )
p224r63_1988  <- brick ( " p224r63_1988_masked.grd " )

plot ( p224r63_1988 )

# exercise plot in rgb both images
par ( mfrow = c ( 2 , 1 ))
plotRGB ( p224r63_2011 , r = 3 , g = 2 , b = 1 , stretch = " Lin " ) # I must remember that red is band 3 etc. to assign the right band to the right color

plotRGB ( p224r63_1988 , r = 3 , g = 2 , b = 1 , stretch = " Lin " )

# plot in false color rgb 432 both images

par ( mfrow = c ( 2 , 1 ))
plotRGB ( p224r63_1988 , r = 4 , g = 3 , b = 2 , stretch = " Lin " )
plotRGB ( p224r63_2011 , r = 4 , g = 3 , b = 2 , stretch = " Lin " )

# accentuate the noise of the images. 2 ways, streccharle more or use multi analysis

par ( mfrow = c ( 2 , 1 ))
plotRGB ( p224r63_1988 , r = 4 , g = 3 , b = 2 , stretch = " hist " ) # histogram stretch, no more linear
plotRGB ( p224r63_2011 , r = 4 , g = 3 , b = 2 , stretch = " hist " )

# depending on the health of the leaf I will have different relationships if I do
# DVI = NIR-RED

dvi2011  <-  p224r63_2011 $ B4_sre  -  p224r63_2011 $ B3_sre  # the dollar connects two things to each other
cld  <- colorRampPalette (c ( ' darkviolet ' , ' light blue ' , ' lightpink4 ' )) ( 100 )
plot ( dvi2011 , col = cld )

# you can see that the dvi is not homogeneous. in the middle of the forest there are leaves with a lot of water probably

# exercise dvi for 1988
dvi1988  <-  p224r63_1988 $ B4_sre  -  p224r63_1988 $ B3_sre  # the dollar connects two things to each other
cld2  <- colorRampPalette (c ( ' darkviolet ' , ' light blue ' , ' orange ' )) ( 100 )
plot ( dvi1988 , col = cld2 )
# new color
dvi1988  <-  p224r63_1988 $ B4_sre  -  p224r63_1988 $ B3_sre  # the dollar connects two things to each other
cld2  <- colorRampPalette (c ( ' darkblue ' , ' blue ' , ' light blue ' )) ( 100 )
plot ( dvi1988 , col = cld2 )

# difference from on year to the other
diff  <-  dvi2011  -  dvi1988
plot ( diff ) # you can see where the dvi has changed the most

# changing the grain

# aggregate () is the function. In practice I reduce the quality of the pixels
p224r63_2011res  <- aggregate ( p224r63_2011 , fact = 10 ) # factor 10
# res means resempling
p224r63_2011res100  <- aggregate ( p224r63_2011 , fact = 100 )
# plot together
par ( mfrow = c ( 3 , 1 ))
plotRGB ( p224r63_2011 , r = 4 , g = 3 , b = 2 , stretch = " Lin " )
plotRGB ( p224r63_2011res , r = 4 , g = 3 , b = 2 , stretch = " Lin " )
plotRGB ( p224r63_2011res100 , r = 4 , g = 3 , b = 2 , stretch = " Lin " )
# you can see how depending on the quality I can make considerations or not
# in res100 nothing is seen of agricultural crops
p224r63_2011  # to get info on the image
# in the last image I have a resolution of 3kmx3km, too little
