library(ggplot2)
library(dplyr)
library(scales)
library(reshape2)
library(lubridate)
library(caret)

df <- read.csv("meat.csv")

df$date <- floor_date(as.Date(df$date), "month")

df["row_number"] <- seq(1:nrow(df))

lng <- melt(df, c("row_number", "date"))

# ggplot(lng, aes(value)) + geom_histogram(colour="white") + facet_wrap(~variable, scales="free")
# 

p <- ggplot(lng, aes(x=date, y=value, group=variable, colour=variable)) + 
  geom_point(size=1, alpha=0.75) + 
  stat_smooth(se=FALSE) + 
  scale_x_date() 
ggsave("stat_smooth.png", p)

g <- group_by(lng, floor_date(date, "year"), variable)
lng.years <- summarise(g, sum(value))
colnames(lng.years) <- c("year", "variable", "value")
lng.years  <- ungroup(lng.years)

p <- ggplot(lng.years, aes(x=year, y=value, fill=variable)) + 
  geom_area() 
ggsave("stacked_area.png", p)


