library(raster)


setwd("C:/lab/no2/") # windows

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
