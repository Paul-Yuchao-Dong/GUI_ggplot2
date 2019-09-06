

df_sorted <- df_ratios %>%
  mutate(region = fct_reorder(region, -student_ratio_region))

ggplot(df_sorted, aes(region, student_ratio))+
  geom_boxplot()
