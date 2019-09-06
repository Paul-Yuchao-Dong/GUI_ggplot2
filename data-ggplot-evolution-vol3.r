

df_sorted <- df_ratios %>%
  mutate(region = fct_reorder(region, -student_ratio_region))

theme_set(theme_light(base_size = 15, base_family = "Poppins"))

ggplot(df_sorted, aes(region, student_ratio, color = region))+
  geom_boxplot()+
  coord_flip()+
  scale_y_continuous(limits = c(0, 90), expand = c(0.005, 0.005))+ #even if there was a coord_flip it was still the scale_y not x
  scale_color_uchicago()+
  labs(x = NULL, y = "Student Teacher Ratio")+
  theme(legend.position = "none",
        panel.grid = element_blank(),
        axis.title = element_text(size = 12),
        axis.text.x = element_text(family = "Roboto Mono", size = 10)
        )





