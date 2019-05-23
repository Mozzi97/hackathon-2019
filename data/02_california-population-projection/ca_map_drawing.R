#search "r california county shapefile" in google and click on "CA Geographic Boundaries - data.ca.gov", downloads "CA County Boundaries" and save it as the same path with your data files

#check the current path
getwd()

#make a values which stores path of CA_Counties file
lcl <- file.path(getwd(), "CA_Counties/")

#install the package
install.packages("rgdal")

library(rgdal)

ogrListLayers(lcl)

#creates variable which stores layer of counties
counties <- readOGR(lcl,"CA_Counties_TIGER2016")

#draw it
plot(counties)
