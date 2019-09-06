library(tidyverse)
library(tidybayes)

model <- rstanarm::stan_glm(Sepal.Length ~ Sepal.Width, gaussian(), iris)

colors <- colorspace::sequential_hcl(5, palette = "Purples")

iris %>%
  tidyr::expand(
    Sepal.Width = seq(min(Sepal.Width), max(Sepal.Width), length.out = 100)
  ) %>%
  add_fitted_draws(model) %>%
  median_qi(.width = c(.95, .85, .5)) %>%
  ggplot()+
    aes(x = Sepal.Width, y = .value) +
    geom_lineribbon(aes(fill = factor(.width), color = .point)) +
    scale_color_manual(
      aesthetics = c("fill", "color"),
      breaks = c("0.5", "0.85", "0.95", "median"),
      values = c(colors[2:4], colors[1])
    ) +
  guides(
    fill = guide_legend(
      title = "Posterior intervals",
      override.aes = list(
        color = c(NA, NA, NA, colors[1]),
        fill = c(colors[2:4], NA)
      )
    ),
    color = FALSE
  )+
  theme_bw()


