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
 
