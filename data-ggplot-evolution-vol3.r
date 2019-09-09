library(showtext)

library(extrafont)
font_import()
loadfonts(device = "win")

font_add_google("Poppins")
font_add_google("Roboto Mono")

df_sorted <- df_ratios %>%
  mutate(region = fct_reorder(region, -student_ratio_region))

theme_set(theme_light(base_size = 15, base_family = "Poppins"))

g <- ggplot(df_sorted, aes(region, student_ratio, color = region))+
  # geom_boxplot()+
  coord_flip()+
  scale_y_continuous(limits = c(0, 90), expand = c(0.005, 0.005))+ #even if there was a coord_flip it was still the scale_y not x
  scale_color_uchicago()+
  labs(x = NULL, y = "Student Teacher Ratio")+
  theme(legend.position = "none",
        panel.grid = element_blank(),
        axis.title = element_text(size = 12),
        axis.text.x = element_text(family = "Roboto Mono", size = 10)
        )

g+geom_boxplot()

g+geom_violin()

g+geom_line(size = 1)

g+geom_point(size = 1)

g+geom_point(size = 3, alpha = 0.15)

g+geom_boxplot(outlier.alpha = 0, color="gray60")+geom_point(size = 3, alpha = 0.15)


g+geom_jitter(alpha = 0.25, width = 0.2, size = 2)

g +
  geom_jitter(alpha = 0.25, width = 0.2, size = 2) +
  stat_summary(fun.y = mean, geom = "point", size = 5)

world_avg <- df_ratios %>%
  summarise(avg = mean(student_ratio, na.rm = T)) %>%
  pull(avg)

set.seed(123)
g +
  geom_hline(aes(yintercept =  world_avg), color = "gray70", size = 0.6 )+
  geom_jitter(alpha = 0.25, width = 0.2, size = 2) +
  stat_summary(fun.y = mean, geom = "point", size = 5)


set.seed(123)
g +
  geom_segment(aes(x = region, xend = region, y = student_ratio_region, yend = world_avg), size = 0.8)+
  geom_hline(aes(yintercept =  world_avg), color = "gray70", size = 0.6 )+
  geom_jitter(alpha = 0.25, width = 0.2, size = 2) +
  geom_point(aes(x = region, y = student_ratio_region), size = 5)

set.seed(123)
(g_text <- g +
  geom_segment(aes(x = region, xend = region, y = student_ratio_region, yend = world_avg), size = 0.8)+
  geom_hline(aes(yintercept =  world_avg), color = "gray70", size = 0.6 )+
  geom_jitter(alpha = 0.25, width = 0.2, size = 2) +
  geom_point(aes(x = region, y = student_ratio_region), size = 5)+
  annotate("text", x = 6.3, y = 35, family = "Poppins", size = 2.7, color = "gray20",
           label = glue::glue("Worldwide average:\n{round(world_avg, 1)} students per teacher")) +
  annotate("text", x = 3.5, y = 10, family = "Poppins", size = 2.7, color = "gray20",
           label = "Continental average") +
  annotate("text", x = 1.7, y = 11, family = "Poppins", size = 2.7, color = "gray20",
           label = "Countries per continent") +
  annotate("text", x = 1.9, y = 64, family = "Poppins", size = 2.7, color = "gray20",
           label = "The Central African Republic has by far\nthe most students per teacher"))

arrows <- tibble(
  x1 = c(6.2, 3.5, 1.7, 1.7, 1.9),
  x2 = c(5.6, 4, 1.9, 2.9, 1.1),
  y1 = c(35, 10, 11, 11, 73),
  y2 = c(world_avg, 19.4, 14.1, 12, 83.4)
)

g_arrows <- g_text +
  geom_curve(data = arrows, aes(x = x1, y = y1, xend = x2, yend = y2),
             color = "gray20",
             curvature = -0.3,
             size = 0.4,
             arrow = arrow(length=unit(0.07,"inch"))
                    )

(g_final <- g_arrows +
  # scale_y_continuous(limits = c(0,90), expand = c(0.005, 0.005),
  #                    breaks = c(1, seq(20,80, by=20))
  #                    )+
    labs(caption = "Data: UNESCO Institute for Statistics")+
    theme(plot.caption = element_text(size = 9, color = "gray50"))
)

g_final +
  annotation_custom(ggplotGrob(map_regions), xmin = 4, xmax = 6, ymin = 55, ymax = 85)
ggsave(filename = "ggplot evolve.png", type = "cairo")
