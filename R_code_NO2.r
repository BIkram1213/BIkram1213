library(raster)

setwd("~/lab/no2/")
# setwd("/Users/utente/lab/no2/") #mac
# setwd("C:/lab/no2/") # windows

# Exercise: import all of the NO2 data in R by the lapply function
rlist <- list.files(pattern="EN")
rlist

import <- lapply(rlist, raster)
EN <- stack(import)
cl <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(EN, col=cl)

# january and march
par(mfrow=c(1,2))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)

# RGB space
plotRGB(EN, r=1, g=7, b=13, stretch="lin")

# difference map
dif <- EN$EN_0013 - EN$EN_0001
cld <- colorRampPalette(c('blue','white','red'))(100) # 
plot(dif, col=cld)

# quantitative estimate!
boxplot(EN)
boxplot(EN,outline=F, horizontal=T, axes=T)

# boxplot(EN,horizontal=T,axes=T,outline=F)

# plot!
plot(EN$EN_0001, EN$EN_0013)
abline(0,1,col="red")

############ 1:1 line with snow data

setwd("~/lab/snow/")
# setwd("/Users/utente/lab/snow/") #mac
# setwd("C:/lab/snow/") # windows

# Exercise: import the snow cover imeages altogether

# fast version of import and plot of many data for lazy people!
rlist <- list.files(pattern="snow20")
rlist

import <- lapply(rlist, raster)
snow.multitemp <- stack(import)

plot(snow.multitemp$snow2000r, snow.multitemp$snow2020r)
abline(0,1,col="red")
