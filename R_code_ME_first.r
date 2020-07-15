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
