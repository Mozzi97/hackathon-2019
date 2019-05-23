unor2019 <- dat %>% 
  dplyr::filter(year == 2019) %>% 
  dplyr::group_by(county) %>% 
  dplyr::summarise(county_total = sum(pop_total))

child2019 <- dat %>% filter(year == 2019) %>% 
  group_by(county) %>% filter(age>=0&age<=18) %>% 
  summarise(child_total = sum(pop_total))

table <- merge(child2019, unor2019)

library(ggplot2)

ggplot(data=table, aes(x=county, y=county_total)) +
  geom_bar(stat="identity") +
  labs(y="number of children", title="Number of children by county")



