## packages
library(tidyverse)
library(ggsci)

## load fonts
extrafont::loadfonts(device = "win")

## tile map as legend
map_regions <- df_ratios %>%
  mutate(region = fct_reorder(region, -student_ratio_region)) %>%
  ggplot(aes(x, y , fill = region, color = region))+
  geom_tile(color="white")+
  scale_y_reverse()+
  scale_fill_uchicago(guide = F)+
  coord_equal()+
  theme_void()
