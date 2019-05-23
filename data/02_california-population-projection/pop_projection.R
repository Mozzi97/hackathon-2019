install.packages(
   "ggplot2",
   repos = c("http://rstudio.org/_packages",
   "http://cran.rstudio.com")
)
library(tidyverse)
library(ggplot2)

#load population projection
#dat = read.csv("dof_dru_pop_1970_2050_csya_wide.csv", header = TRUE)
dat <- read_csv("dof_dru_pop_1970_2050_csya_wide.csv")

my2019 <- dat %>% filter(year == 2019) %>% group_by(county) 
	%>% summarise(county_total = sum(pop_total)) %>% arrange(desc(county_total))
top10 <- my2019 %>% filter(county_total > 1000000)

#summary(dat)
#plot(x = dat$year, y = dat$pop_total, xlim = 2019)

#geom_point of top 10 population county in CA, 2019
ggplot(data=top10) 
	+ aes(x=county, y=county_total) 
	+ geom_point() 
	+ theme(axis.text.x = element_text(face = "bold", color = "#993333",  
	+ size = 8, angle = 20)

#map_plot of top 10 population county in CA, 2019
#install.packages("mapdata")
states <- map_data("state")
ggplot(data = states) + 
  geom_polygon(aes(x = long, y = lat, fill = region, group = group), color = "white") + 
  coord_quickmap() +
  guides(fill = FALSE)  # do this to leave off the color legend

ca <- states %>%
  filter(region %in% c("california"))

ggplot(data = west_coast) + 
  geom_polygon(aes(x = long, y = lat), fill = "palegreen", color = "black") 

#California

ca_df <- states %>%
  filter(region == "california")

counties <- map_data("county")
ca_county <- counties %>%
  filter(region == "california")

ca_base <- ggplot(data = ca_df, mapping = aes(x = long, y = lat, group = group)) + 
  coord_quickmap() + 
  geom_polygon(color = "black", fill = "gray")
ca_base + theme_void()


#population growth rate of LA
LAgrowth <- dat %>% filter(county == "LOS ANGELES") %>% group_by(year) 
	%>% summarise(county_total = sum(pop_total)) %>% arrange(desc(county_total))

#draw population growth rate of LA
ggplot(data = LAgrowth) + aes(x = year, y = county_total, 
	title = "Population Growth Rate of Los Angeles from 1970 to 2050", 
	xlab = "years", ylab = "Population of Los Angeles")+ geom_point() 


#child population
child2019 <- dat %>% filter(year == 2019) %>% group_by(county) 
	%>% filter(age>=0&age<=18) %>% summarise(child_total = sum(pop_total))



