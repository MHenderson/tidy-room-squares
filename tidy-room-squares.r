library(dplyr)
library(ggplot2)
library(munsell)
library(tibble)

source("grid_functions.r")

X <- tribble(
  ~row, ~col, ~first, ~second,
     1,    1,      0,       7,
     1,    4,      1,       5,
     1,    6,      4,       6,
     1,    7,      2,       3,
     2,    1,      3,       4,
     2,    2,      1,       7,
     2,    5,      2,       6,
     2,    7,      0,       5,
     3,    1,      1,       6,
     3,    2,      4,       5,
     3,    3,      2,       7,
     3,    6,      0,       3,
     4,    2,      0,       2,
     4,    3,      5,       6,
     4,    4,      3,       7,
     4,    7,      1,       4,
     5,    1,      2,       5,
     5,    3,      1,       3,
     5,    4,      0,       6,
     5,    5,      4,       7,
     6,    2,      3,       6,
     6,    4,      2,       4,
     6,    5,      0,       1,
     6,    6,      5,       7,
     7,    3,      0,       4,
     7,    5,      3,       5,
     7,    6,      1,       2,
     7,    7,      6,       7
)

Y <- expand.grid(row = 1:7, col = 1:7)

XX <- left_join(Y, X)

text_colour <-"#ffffff"
low_colour <- mnsl("5P 2/12")
high_colour <- mnsl("5P 7/12")
na_colour <- "grey"

ggplot(data = XX, aes(col, row)) +
  geom_tile(aes(fill = pmin(first, second))) +
  geom_text(aes(label = paste0("{", first, "," ,second, "}")), data = XX %>% filter(!is.na(first)), color = text_colour, size = 3) +
  geom_segment(data = grid_lines(7, 7), aes(x = x, y = y, xend = xend, yend = yend), size = .1) +
  scale_y_reverse() +
  scale_fill_gradient(low = low_colour, high = high_colour, na.value = na_colour) +
  coord_fixed() + 
  theme_void() +
  theme(
    legend.position  = "none"
  )

ggsave("min.svg", width = 3, height = 3)

ggplot(data = XX, aes(col, row)) +
  geom_tile(aes(fill = pmax(first, second))) +
  geom_text(aes(label = paste0("{", first, "," ,second, "}")), data = XX %>% filter(!is.na(first)), color = text_colour, size = 3) +
  geom_segment(data = grid_lines(7, 7), aes(x = x, y = y, xend = xend, yend = yend), size = .1) +
  scale_y_reverse() +
  scale_fill_gradient(low = low_colour, high = high_colour, na.value = na_colour) +
  coord_fixed() +
  theme_void() +
  theme(
    legend.position  = "none",
  )

ggsave("max.svg", width = 3, height = 3)
