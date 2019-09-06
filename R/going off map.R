library(dplyr)
library(purrr)
library(gapminder)
library(tidyr)

gapminder %>%
  group_by(country) %>%
  nest() %>%
  mutate(fit = map(data, ~ lm(lifeExp ~ gdpPercap, data = .x))) %>%
  mutate(rsq = map_dbl(fit, ~ summary(.x)[["r.squared"]])) %>%
  arrange(rsq)

my_vector <- c(1.0212, 2.483, 3.189, 4.5938)

map_dbl(my_vector, round)
map_dbl(my_vector, ~ .x + 10)

keep(my_vector, ~ .x < 3)
discard(my_vector, ~ .x < 3)

mixed_list <- list("happy", 2L, 4.39)

add_ten <- function(n) {
  n + 10
}

map(mixed_list, add_ten)

map_if(mixed_list, is.numeric, add_ten) %>% as.numeric()

possibly_add_ten <- possibly(add_ten, otherwise = "I'm not numeric")

map(mixed_list, possibly_add_ten)
mixed_list <- set_names(mixed_list, letters[1:3])

map(mixed_list, safely(add_ten))

mixed_list %>%
  map(safely(add_ten)) %>%
  map("error") %>%
  compact()

composed_funs <- compose(round, log, add_ten)

c(1, 20, 500) %>%
  composed_funs()
