setwd("~/lab")
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
