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
