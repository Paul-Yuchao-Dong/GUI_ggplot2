

df_sorted <- df_ratios %>%
  mutate(region = fct_reorder(region, -student_ratio_region))

ggplot(df_sorted, aes(region, student_ratio))+
  geom_boxplot()+
  scale_y_continuous(limits = c(0, 90))+ #even if there was a coord_flip it was still the scale_y not x
  coord_flip()

