.mn.
install.packages ("spatstat")
library ( spatstat )

attach ( covid )
head ( covid )

covids  <- ppp ( lon , lat , c ( - 180 , 180 ), c ( - 90 , 90 )) # c from the ranges of the variables

? ppp  # gives info on what i can write in ppp

# if I don't want to attack covid just add covid $ to each variable, eg covid $ lon

d  <- density ( covids ) # map built next step the monster

plot ( d )
points ( covids ) # I have to keep the chart window open otherwise it doesn't work

# new lesson

# load the old session

library ( spatstat )
plot ( d )
points ( covids )

# now I add the coast lines to see the map related to the territories
install.packages ( " rgdal " )
library ( rgdal )

# I now import the coastline. it is structured like this (x0y0, x1y1 ...)

coastlines  <- readOGR ( " ne_10m_coastline.shp " ) # capitalized OGR otherwise it doesn't work

plot ( d )
points ( covids )
plot ( coastlines , add = T ) # add means add the line to the previous image

# change of the color
cl  <- colorRampPalette (c ( " yellow " , " orange " , " red " )) ( 100 )
# decide which colors will be the highest and lowest
# above goes from yellow to red, 100 indicates that it puts. 100 colors between yellow and red (gradation)

plot ( d , col = cl , main = " Density of covid-19 " ) # I assign the cl object that is associated with a color function as color
points ( covids )
plot ( coastlines , add = T )

# exercise: new color ramp palette
cl2  <- colorRampPalette (c ( " light green " , " yellow " , " orange " , " red " )) ( 100 ) # i can put as many colors as i want

# export this map to PDF
pdf ( " covid_density.pdf " )
cl2  <- colorRampPalette (c ( " light green " , " yellow " , " orange " , " red " )) ( 100 )
plot ( d , col = cl2 , main = " Density of covid-19 " )
points ( covids )
plot ( coastlines , add = T )
dev.off () # I close the window so I have the pdf. I can do the same thing with the PNG
# pdf is better, it doesn't ruin the image quality

png ( " covid_density.png " )
cl2  <- colorRampPalette (c ( " light green " , " yellow " , " orange " , " red " )) ( 100 )
plot ( d , col = cl2 , main = " Density of covid-19 " )
points ( covids )
plot ( coastlines , add = T )
dev.off ()

