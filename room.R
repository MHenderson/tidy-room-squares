library(dplyr)
library(ggplot2)
library(tibble)

source("grid_functions.r")

filled <- tribble(
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

all_cells <- expand.grid(row = 1:7, col = 1:7)

filled_and_empty <- left_join(all_cells, filled)

ggplot(data = filled_and_empty, aes(col, row)) +
  geom_tile(aes(fill = factor(first))) +
  geom_tile(aes(fill = factor(second)), height = .5, width = .5) +
  geom_segment(data = grid_lines(7, 7), aes(x = x, y = y, xend = xend, yend = yend), size = .1) +
  scale_fill_brewer(palette = "Set1") +
  scale_y_reverse() +
  coord_fixed() + 
  theme_void() +
  theme(
    legend.position  = "none"
  )

ggsave("room.png", width = 1, height = 1)
