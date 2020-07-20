# 1 R code first
# 2 Multipanel in R
# 3 R Code for Spatial Point
# 4 R Code for Multivariate analysis
# 5 R Code Remote Sensing
# 6 R Code Point Pattern Analysis
# 7 R Code RS Data analysis
# 8 R Code Ecosystem Function
# 9 R Code Radiance
# 10 R Code FAPAR
# 11 R Code Biodiversity
# 12 R Code Snow
# 13 R Code NO2
#14 R Code SDM
# 15. R Code Crop
# 16 R Code Exam

1.	R code first
install.packages("sp")
library(sp)
data(meuse)
# Look at the meuse dataset
meuse
# Look at the first row of the dataset
# # used for explaination, # does not read the data
head(meuse)
# lets plot two variables
attach(meuse)
plot(zinc,copper)
plot(zinc,copper, col="blue")
plot(zinc,copper, col="blue",pch=22)
plot(zinc,copper, col="blue",pch=22,cex=3)
# col is used to change the color, pch is is to chnage the shapes and cex is the scale of text and symbols

#---------------------------------------------------------------------------------------------------------

2.	Multipanel in R
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
       
       
#---------------------------------------------------------------------------------------------------------
       
       
3.	R code for Spatial Point
install.packages("sp")
library(sp)
data(meuse)
head(meuse)

# coordinates
coordinates(meuse) = ~x+y      

plot(meuse)
spplot(meuse, "zinc")

# Plot the spatial amount of copper
spplot(meuse, "copper", main="Copper concentration")
# main is used to provide headings to the graph/table
bubble(meuse, "zinc")
bubble(meuse, "zinc", main="Zinc concentration")
# Bubble used to make the points bigger and more readable
# Exercise: bubble copper in red
bubble(meuse, "copper", main="Cppoer concentration", col="red")

# Importing new data

# download covid_agg.csv file and build a folder called lab into C: 
# put the covid_agg.csv file into the folder lab

# setting the working directory: lab
# setwd("C:/lab/") for windows
setwd("C:/lab")

covid <- read.table("covid_agg.csv", head=T)
head(covid)

attach(covid)
plot(country,cases)

# plot(covid$country,covid$cases)
plot(country, cases, las=0) # parallel labels
plot(country, cases, las=1) # horizontal labels
plot(country, cases, las=2) # perpendicular labels
plot(country, cases, las=3) # vertical labels
# las changes the label directions in the axis
plot(country, cases, las=3, cex.axis=0.5)
plot(country, cases, las=3, cex.axis=0.7)

# ggplot2 package
install.packages("ggplot2")
library(ggplot2)  # require(ggplot2)
install.packages("ggplot2")

# If ggplot2 cannot be found by the software: install the devtools package and then install 
# install.packages("devtools")

# setting the working directory: lab
# Windows
# setwd("C:/lab/")
setwd("C:/lab")

load("spatial.RData")
ls()
# covid

install.packages("ggplot2")
library(ggplot2) #require(ggplot2)
#ggplot is to beautify the graphs
data(mpg)
head(mpg)
# key components: data, aes, geometry
ggplot(mpg, aes(x=displ,y=hwy)) + geom_point()
ggplot(mpg, aes(x=displ,y=hwy)) + geom_line()
ggplot(mpg, aes(x=displ,y=hwy)) + geom_polygon()
#
head(covid)
ggplot(covid, aes(x=lon, y=lat, size=cases)) + geom_point()
       
       
#---------------------------------------------------------------------------------------------------------

4.	R code for Multivirate analysis
install.packages("vegan")
library(vegan)
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

#---------------------------------------------------------------------------------------------------------
       
       
5.	R code Remote Sensing
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
#---------------------------------------------------------------------------------------------------------
6.	R code Point Pattern Analysis
nstall.packages ("spatstat")
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

#---------------------------------------------------------------------------------------------------------
7.	R code
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

#---------------------------------------------------------------------------------------------------------

8 R Code Ecosystem Function
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
#---------------------------------------------------------------------------------------------------------

9 R Code Radiance
library(raster)

toy <- raster(ncol=2, nrow=2, xmn=1, xmx=2, ymn=1, ymx=2)
values(toy) <- c(1.13,1.44,1.55,3.4)
#add values to the toy
plot(toy)
text(toy, digits=2) 
# only two numbers
toy2bits <- stretch(toy,minv=0,maxv=3)
storage.mode(toy2bits[]) = "integer"

toy3bits <- stretch(toy,minv=0,maxv=7)



plot(toy3bits)
text(toy3bits, digits=2)

toy4bits <- stretch(toy,minv=0,maxv=15)
storage.mode(toy4bits[]) = "integer"

plot(toy4bits)
text(toy4bits, digits=2)


toy8bits <- stretch(toy,minv=0,maxv=255)
storage.mode(toy8bits[]) = "integer"

plot(toy8bits)
text(toy8bits, digits=2)


# plot together
par(mfrow=c(1,4))

plot(toy)
text(toy, digits=2)

plot(toy2bits)
text(toy2bits, digits=2)

plot(toy4bits)
text(toy4bits, digits=2)

plot(toy8bits)
text(toy8bits, digits=2)
#---------------------------------------------------------------------------------------------------------

10 R Code FAPAR
levelplot(copNDVI)

library(raster)
library(rasterVis)
library(rasterdiv)


plot(copNDVI)
copNDVI <- reclassify(copNDVI, cbind(253:255, NA)) 
#remove water data which are 253 and 255

levelplot(copNDVI)

setwd("C:/lab/")

faPAR10 <- raster("faPAR10.tif")

levelplot(faPAR10) 
# different from the previous graph -> we had high NDVI in the equator and in the forest in the north
# in forests with low 3D structure some part of the light are unused and goes into the soil.
pdf("copNDVI.pdf")
levelplot(copNDVI)
dev.off()

pdf("faPAR.pdf")
levelplot(faPAR10)
dev.off()

############### day 2
library(raster)
library(rasterdiv)
library(rasterVis)


setwd("C:/lab/")

load("faPAR.RData")

# the original faPAR from Copernicus is 2GB
# let's see how much spae is needed for an 8-bit set 

writeRaster(copNDVI, "copNDVI.tif")
# 5.3MB

# faPAR: levelplot this set
levelplot(faPAR10)

#### regression model between faPAR and NDVI
erosion <- c(12, 14, 16, 24, 26, 40, 55, 67)
hm <- c(30, 100, 150, 200, 260, 340, 460, 600)

plot(erosion, hm, col="red", pch=19, xlab="erosion", ylab="heavy metals")

model1 <- lm(hm ~ erosion)
summary(model1)
abline(model1)

#### faPAR vs. NDVI model
library(raster)
library(rasterdiv)
library(sf) # to call st_* functions
# install.packages("sf")

setwd("C:/lab/")
faPAR10 <- raster("faPAR10.tif")
plot(faPAR10)
plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA), right=TRUE)

random.points <- function(raster,n)
{
lin <- rasterToContour(is.na(raster))
pol <- as(st_union(st_polygonize(st_as_sf(lin))), 'Spatial') # st_union to dissolve geometries
pts <- spsample(pol[1,], n, type = 'random')
}

pts <- random.points(faPAR10,1000)
copNDVIp <- extract(copNDVI, pts)
faPAR10p <- extract(faPAR10,pts)

# photosynthesis vs. biomass
model2 <- lm(faPAR10p ~ copNDVIp)
summary(model2)
plot(copNDVIp, faPAR10p, col="green", xlab="biomass", ylab="photosynthesis")
abline(model2, col="red")
#---------------------------------------------------------------------------------------------------------

11 R Code Biodiversity
library(raster)
clad <- brick("cladonia_stellaris_calaita.JPG))")
clad <- brick("cladonia_stellaris_calaita.JPG")
window <- matrix(1, nrow = 3, ncol = 3)
window
sd_sntr <- focal(snt_r10$snt_r10.4, w=window, fun=sd)
sd_sntr <- focal(clad, w=window, fun=sd) 
clad
sd_sntr <- focal(clad[,1], w=window, fun=sd) 
sd_sntr <- focal(clad$cladonia_stellaris_calaita.1, w=window, fun=sd) 
plot(sd_sntr) 
cl <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(sd_sntr,col=cl) 
cl <- colorRampPalette(c('yellow','orange','violet'))(100) # 
plot(sd_sntr,col=cl) 
cl <- colorRampPalette(c('yellow','violet','black'))(100) # 
plot(sd_sntr,col=cl) 
clado <- stack(clad, sd_sntr)
plot(clado)
plot(clado,col=cl)
par(mfrow=c(1,2)) 
plotRGB(clad,3,2,1,stretch="lin")
plot(sd_sntr,col=cl) 
pdf("clad_enhancement.png")
par(mfrow=c(1,2)) 
plotRGB(clad,3,2,1,stretch="lin")
plot(sd_sntr,col=cl) 
dev.off()
q()
#---------------------------------------------------------------------------------------------------------

12 R Code Snow
Setwd("C:/lab/")
snowmay <- raster("c_gls_SCE500_202005180000_CEURO_MODIS_V1.0.1.nc")

cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 

# Exercise: plot the snow cover with the color ramp palette
plot(snowmay, col=cl)
# to have info about the n of pixels
#snowmay

# Slow manner to import the set
setwd("~/lab/snow/")

snow2000 <- raster("snow2000r.tif")
snow2005 <- raster("snow2005r.tif")
snow2010 <- raster("snow2010r.tif")
snow2015 <- raster("snow2015r.tif")
snow2020 <- raster("snow2020r.tif")

par(mfrow=c(2,3))
plot(snow2000, col=cl)
plot(snow2005, col=cl)
plot(snow2010, col=cl)
plot(snow2015, col=cl)
plot(snow2020, col=cl)

##############

# fast version of import and plot of multiple data 
# first  make the list of files -> list.files, with a common pattern 
rlist <- list.files(pattern="snow")
rlist

import <- lapply(rlist, raster)
snow.multitemp <- stack(import)
plot(snow.multitemp, col=cl)

# let's make a prediction
source("prediction.r")

plot(predicted.snow.2025.norm, col=cl)


########################################## 

## day 2nd


setwd("C:/lab/snow/") # windows

# Exercise: import the snow cover imeages altogether

# fast version of import and plot of many data for lazy people!
rlist <- list.files(pattern="snow")
rlist

import <- lapply(rlist, raster)
snow.multitemp <- stack(import)

cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 
plot(snow.multitemp, col=cl)


prediction <- raster("predicted.2025.norm.tif")
plot(prediction, col=cl)

# export the output


writeRaster(prediction, "final.tif")

# final stack
final.stack <- stack(snow.multitemp, prediction)
plot(final.stack, col=cl)

# export the R graph for your beautiful thesis!
pdf("my_final_exciting_graph.pdf")
plot(final.stack, col=cl)
dev.off()

png("my_final_exciting_graph.png")
plot(final.stack, col=cl)
dev.off()
#---------------------------------------------------------------------------------------------------------

13 R Code NO2
library(raster)


setwd("C:/lab/NO2/") # windows

# Exercise: import all of the NO2 data in R by the lapply function
rlist <- list.files(pattern="EN")
rlist
# apply the raster function to all the objects in the list at the same time
import <- lapply(rlist, raster)
# create a stack of all the rasters 
EN <- stack(import)
cl <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(EN, col=cl)

# january and march
par(mfrow=c(1,2))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)

# RGB space
#R = EN_0001, G=0007 and B=0013, so that if the levels in the beginning were higher we will see it in red in green we see the middle level and in blue the latest values (march)
plotRGB(EN, r=1, g=7, b=13, stretch="lin")

# difference map
dif <- EN$EN_0013 - EN$EN_0001
cld <- colorRampPalette(c('blue','white','red'))(100) # 
plot(dif, col=cld)

# quantitative estimate!
boxplot(EN)
boxplot(EN,outline=F, horizontal=T, axes=T)
#remove outline, horizontal boxplot, put axes

# boxplot(EN,horizontal=T,axes=T,outline=F)

# plot!
plot(EN$EN_0001, EN$EN_0013)
abline(0,1,col="red")

# 1:1 line with snow data


setwd("C:/lab/snow/") 

# Exercise: import the snow cover imeages altogether

rlist <- list.files(pattern="snow20")
rlist

import <- lapply(rlist, raster)
snow.multitemp <- stack(import)

plot(snow.multitemp$snow2000r, snow.multitemp$snow2020r)
abline(0,1,col="red")
#---------------------------------------------------------------------------------------------------------
14 R Code SDM
install.packages("sdm")
# install.packages("rgdal", dependencies=T)

library(sdm)
library(raster) # predictors
library(rgdal) # species

file <- system.file("external/species.shp", package="sdm") 
species <- shapefile(file)

species
species$Occurrence

plot(species[species$Occurrence == 1,],col='blue',pch=16)
points(species[species$Occurrence == 0,],col='red',pch=16)

# predictors
path <- system.file("external", package="sdm") 

lst <- list.files(path=path,pattern='asc$',full.names = T) #
lst

preds <- stack(lst)

cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16) # present wrt elevation

plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16) # present wrt temperature

plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)# present wrt percipitation

plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=16) # present wrt vegetation

# model
# sdm = species distribution model 
# glm = generalized linear model

d <- sdmData(train=species, predictors=preds)

m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=d, methods = "glm")

p1 <- predict(m1, newdata=preds) 

plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)

s1 <- stack(preds,p1)
plot(s1, col=cl)
#---------------------------------------------------------------------------------------------------------

15. R Code Crop
setwd("C:/la/b")
library(raster)
library(ncdf4) 

snow <- raster("c_gls_SCE500_202005180000_CEURO_MODIS_V1.0.1.nc")

cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 
plot(snow, col=cl)

ext <- c(0, 20, 35, 50)
zoom(snow, ext=ext)

# crop and create a new image
snowitaly <- crop(snow, ext) 
plot(snowitaly, col=cl) 

# zoom(snow, ext=drawExtent())
# crop(snow, drawExtent())

#---------------------------------------------------------------------------------------------------------
  16. R Code Exam
  setwd("C:/lab/")
library ( ncdf4 )
library ( raster )
library ( rasterVis )
library ( rasterdiv )
library ( rgdal )
library(RStoolbox)
library ( gdalUtils )


#LAI

#LAI 2000

LAI00 <- raster("c_gls_LAI_200006100000_GLOBE_VGT_V2.0.2.nc")
plot(LAI00)
ext <- c(87, 93, 20, 25)
zoom(LAI00, ext=ext)
LAISB00 <- crop(LAI00, ext)
plot(LAISB00)
plot(LAISB00, main="LAI SB 2000")

#LAI 2010

LAI10 <- raster("c_gls_LAI_201006100000_GLOBE_VGT_V2.0.1.nc")
plot(LAI10)
ext <- c(87, 93, 20, 25)
LAISB10 <- crop(LAI10, ext)
plot(LAISB10)
plot(LAISB10, main="LAI SB 2010")

#LAI 2020

LAI20 <- raster("c_gls_LAI-RT2_202006100000_GLOBE_PROBAV_V2.0.1.nc")
plot(LAI20)
ext <- c(87, 93, 20, 25)
LAISB20 <- crop(LAI20, ext)
plot(LAISB20)
plot(LAISB20, main="LAI SB 2020")

pdf ( " LAISB.multitemp.pdf " )
par ( mfrow = c ( 1 , 1 ))
plot ( LAISB00 , main = "LAI SB 2000" )
plot ( LAISB10 , main = "LAI SB 2010" )
plot ( LAISB20 , main = "LAI SB 2020" )
dev.off()

# Difference 2020 2000

DIFLAI2000  <-  LAISB20  -  LAISB00
plot(DIFLAI2000)
cl  <- colorRampPalette (c('red','white','black')) ( 100 )
plot(DIFLAI2000, col=cl, main="DIF 20-00")

# Difference 2010 2000
DIFLAI1000  <-  LAISB10  -  LAISB00
plot(DIFLAI1000, col=cl, main="DIF 10-00")

# Difference 2020 2010
DIFLAI2010  <-  LAISB20  -  LAISB10
plot(DIFLAI2010, col=cl, main="DIF 20-10")
pdf("DIFLAI.pdf"")
par ( mfrow = c ( 1 , 3 ))
plot(DIFLAI2000, col=cl, main="DIF 20-00")
plot(DIFLAI1000, col=cl, main="DIF 10-00")
plot(DIFLAI1020, col=cl, main="DIF 20-10")
dev.off()

# FCOVER
# FC 2000

FC00 <- raster("c_gls_FCOVER_200001100000_GLOBE_VGT_V2.0.2.nc")
plot(FC00)
ext <- c(87, 93, 20, 25)
zoom(LAI00, ext=ext)
FCSB00 <- crop(FC00, ext)
plot(FCSB00)
plot(FCSB00, main="FC SB 2000")

#FC 2010
FC10 <- raster("c_gls_FCOVER_201001100000_GLOBE_VGT_V2.0.1.nc")
plot(FC10)
ext <- c(87, 93, 20, 25)
FCSB10 <- crop(FC10, ext)
plot(FCSB10)
plot(FCSB10, main="FC SB 2010")

#FC2020
FC20 <- raster("c_gls_FCOVER-RT6_202001100000_GLOBE_PROBAV_V2.0.1.nc")
plot(FC20)
ext <- c(87, 93, 20, 25)
FCSB20 <- crop(FC20, ext)
plot(FCSB20)
plot(FCSB20, main="FC SB 2020")
par ( mfrow = c ( 1 , 3 ))
plot(FCSB00, main="FC SB 2000")
plot(FCSB10, main="FC SB 2010")
plot(FCSB20, main="FC SB 2020")

#DIFFERENCE

DIFFC2000  <-  FCSB20  -  FCSB00
plot(DIFFC2000)
cl  <- colorRampPalette (c('red','white','black')) ( 100 )
plot(DIFFC2000, col=cl, main="DIF 20-00")

# Difference 2010 2000
DIFFC1000  <-  FCSB10  -  FCSB00
plot(DIFFC1000, col=cl, main="DIF 10-00")

# Difference 2020 2010
DIFFC2010  <-  FCSB20  -  FCSB10
plot(DIFFC2010, col=cl, main="DIF 20-10")
pdf("DIFFC.pdf"")
par ( mfrow = c ( 1 , 3 ))
plot(DIFFC2000, col=cl, main="DIF 20-00")
plot(DIFFC1000, col=cl, main="DIF 10-00")
plot(DIFFC2010, col=cl, main="DIF 20-10")
dev.off()

#LANDCOVER
#LC 2000

LC00<-brick("ESACCI-LC-L4-LCCS-Map-300m-P1Y-2000-v2.0.7.tif")
plot(LC00)
LCSHP  <- readOGR ("C:/lab/Sundarbans_2015poly.shp")

plot ( LCSHP ) 
proj4string ( LC00 )
extshp  <- spTransform ( LCSHP , proj4string ( LC00 ))
LCSB00  <- mask (crop ( LC00 , extent ( extshp )), extshp )
plot(LCSB00)

#LC 2005
LC05<-brick("ESACCI-LC-L4-LCCS-Map-300m-P1Y-2005-v2.0.7.tif")
plot(LC05)
proj4string ( LC05 )
extshp  <- spTransform ( LCSHP , proj4string ( LC05 ))
LCSB05  <- mask (crop ( LC05 , extent ( extshp )), extshp )
plot(LCSB05)

#LC 2010
LC10<-brick("ESACCI-LC-L4-LCCS-Map-300m-P1Y-2010-v2.0.7.tif")
plot(LC10)
proj4string ( LC10 )
extshp  <- spTransform ( LCSHP , proj4string ( LC10 ))
LCSB10  <- mask (crop ( LC10 , extent ( extshp )), extshp )
plot(LCSB10)

#LC 2015
LC15<-brick("ESACCI-LC-L4-LCCS-Map-300m-P1Y-2015-v2.0.7.tif")
plot(LC15)
proj4string ( LC15 )
extshp  <- spTransform ( LCSHP , proj4string ( LC15 ))
LCSB15  <- mask (crop ( LC15 , extent ( extshp )), extshp )
plot(LCSB15)

par ( mfrow = c ( 2 , 2 ))
plot(LCSB00, main="LC 2000")
plot(LCSB05, main="LC 2005")
plot(LCSB10, main="LC 2010")
plot(LCSB15, main="LC 2015")


#DIFFERENCE
# DIF 2015 -2000
DIFFC1500  <-  LCSB15  -  LCSB00
plot(DIFFC1500)
cl  <- colorRampPalette (c('red','white','black')) ( 100 )
plot(DIFFC1500, col=cl, main="DIF 15-00")

# DIF 2015 -2005
DIFFC1505  <-  LCSB15  -  LCSB05
plot(DIFFC1505)
cl  <- colorRampPalette (c('red','white','black')) ( 100 )
plot(DIFFC1505, col=cl, main="DIF 15-05")

# DIF 2015 -2010
DIFFC1510  <-  LCSB15  -  LCSB10
plot(DIFFC1510)
cl  <- colorRampPalette (c('red','white','black')) ( 100 )
plot(DIFFC1510, col=cl, main="DIF 15-10")
par ( mfrow = c ( 1 , 3 ))
plot(DIFFC1510,col=cl, main="LC DIF 15 10")
plot(DIFFC1505,col=cl, main="LC DIF 15 05")
plot(DIFFC1500,col=cl, main="LC DIF 15 00")

GI1995<-brick("1995.tif")
plot(GI1995)
plot(GI1995$X1995.1)
clr <- colorRampPalette(c("dark grey","grey","light grey"))(100)
plot(GI1995$X1995.1, col=clr)



GI2015<-brick("2015.tif")
plot(GI2015)
plot(GI2015$X2015.1)

par ( mfrow = c ( 1 , 2 ))
plot(GI1995$X1995.1, main="SI 1995")
plot(GI2015$X2015.1, main="SI 2015")

#DIFFERENCE
DIFSI  <-  GI2015$X2015.1-GI1995$X1995.1
plot(DIFSI)
cl  <- colorRampPalette (c('red','white','black')) ( 100 )
plot(DIFSI, col=cl, main="DIF SI 2015-1995")


