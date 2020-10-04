# Compare AQ data for Durham and San Francisco 

library(readr)
library(dplyr)
library(ggplot2)
library(ggpubr)

durham <- read_csv("OpenAQDurham.csv")
sanfran <- read_csv("OpenAQSanFran.csv")

# Durham data

o3d <- durham %>% filter(parameter == "o3")
plot_o3d <- o3d %>% ggplot(aes(x=utc, y=value, color=location)) + 
  geom_point(shape=3) + 
  labs(x="Month", y="Levels (ppm)", title="Durham Ozone", color="Location")

pm25d <- durham %>% filter(parameter == "pm25")
plot_pm25d <- pm25d %>% ggplot(aes(x=utc, y=value, color=location)) + 
  geom_point(shape=3) + 
  labs(x="Month", y="Levels (µg/m³)", title="Durham PM25", color="Location")

ggarrange(plot_o3d, plot_pm25d)

# SF data

o3sf <- sanfran %>% filter(parameter == "o3") %>% group_by(utc) %>% summarise(avg = mean(value))
plotsfo3 <- o3sf %>% ggplot(aes(x=utc, y=avg)) +
  geom_point(shape=3) + 
  labs(x="Day", y="Avg Levels (ppm)", title="SF Ozone")

pm25sf <- sanfran %>% filter(parameter == "pm25") %>% group_by(utc) %>% summarise(avg = mean(value))
plotsfpm <- pm25sf %>% ggplot(aes(x=utc, y=avg)) +
  geom_point(shape=3) + 
  labs(x="Day", y="Avg Levels (µg/m³)", title="SF PM25")

ggarrange(plotsfo3, plotsfpm)
