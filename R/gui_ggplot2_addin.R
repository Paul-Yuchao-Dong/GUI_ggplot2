library(tidyverse)
library(ggplot2)
p <- ggplot(data = d) +
  aes(x = log(gdpPercap), y = lifeExp, color = continent, size = pop) +
  geom_point() +
  theme_minimal() +
  facet_wrap(vars(year))
p
library(export)
graph2ppt(file="effect plot.pptx", width=7, height=5)

library(ggupset)
tidy_movies %>%
  distinct(title, year, length, .keep_all=TRUE) %>%
  pull(Genres)
