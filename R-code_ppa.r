install.packages ("spatstat")
library ( spatstat )
setwd("C:/lab/")
attach ( covid )
#attac the covid file
head ( covid )
# head points out the data headers
covids  <- ppp ( lon , lat , c ( - 180 , 180 ), c ( - 90 , 90 )) 
# ppp is to point data set on x axis and y axis in a two dimensional surface
# lon lat puts the value of the axis

? ppp  # gives info of what ppp is 

d  <- density ( covids ) # map built next step the monster
# d sets the density value of our covid data  
plot ( d )
points ( covids ) 
# points highlights out data in points on the chart

# next class
setwd("C:/lab/")
library ( spatstat )
plot ( d )
points ( covids )

# lets add the coastlines from the shp
install.packages ( " rgdal " )
library ( rgdal )

# rgdal uses shape files vector lines, like gis lines like  (x0y0, x1y1 ...)

coastlines  <- readOGR ( " ne_10m_coastline.shp " ) 
plot ( d )
points ( covids )
plot ( coastlines , add = T ) 
# add to not erase the previos data, like the covid points

# change the color
cl  <- colorRampPalette (c ( " yellow " , " orange " , " red " )) ( 100 )
# decide which colors from low to high
# increases from yellow to red, 100 is the highest

plot ( d , col = cl , main = " Density of covid-19 " ) 
# cl is to put colour
points ( covids )
plot ( coastlines , add = T )

# new color ramp palette
cl2  <- colorRampPalette (c ( " white " , " yellow " , " orange " , " red " )) ( 100 ) 

# export to PDF
pdf ( " covid_density.pdf " )
cl2  <- colorRampPalette (c ( " white " , " yellow " , " orange " , " red " )) ( 100 )
plot ( d , col = cl2 , main = " Density of covid-19 " )
points ( covids )
plot ( coastlines , add = T )
dev.off () # closes the window to have the pdf.
# pdf is better

png ( " covid_density.png " )
cl2  <- colorRampPalette (c ( " light green " , " yellow " , " orange " , " red " )) ( 100 )
plot ( d , col = cl2 , main = " Density of covid-19 " )
points ( covids )
plot ( coastlines , add = T )
dev.off ()

