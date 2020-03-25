install.packages("sp")
library(sp)
data(meuse)
# Look at the meuse dataset
meuse
# Look at the first row of the dataset
head(meuse)
# lets plot two variables
attach(meuse)
plot(zinc,copper)
plot(zinc,copper, col="blue")
plot(zinc,copper, col="blue",pch=22)
plot(zinc,copper, col="blue",pch=22,cex=3)
