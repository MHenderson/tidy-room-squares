library(dplyr)
library(ggplot2)
library(tibble)

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

XX %>%
  ggplot(aes(col, row, label = paste0("{", first, ",", second, "}"))) +
  geom_tile(aes(fill = first + second)) +
  geom_text(data = XX %>% filter(!is.na(first)), color = "white", size = 5) +
  scale_y_reverse() +
  coord_fixed() +
  theme_void() +
  theme(
    legend.position  = "none",
  )

horiz_lines <- function(n_rows, n_cols) {
  tibble(
       x = rep(0, n_rows + 1)  + .5,
       y = 0:n_rows + .5,
    xend = rep(n_cols, n_rows + 1) + .5,
    yend = 0:n_rows + .5
  )
}

vertical_lines <- function(n_rows, n_cols) {
  tibble(
       x = 0:n_cols + .5,
       y = rep(0, n_cols + 1) + .5,
    xend = 0:n_cols + .5,
    yend = rep(n_rows, n_cols + 1) + .5
  )
}

grid_lines <- function(n_rows, n_cols) {
  bind_rows(
    horiz_lines(n_rows, n_cols),
    vertical_lines(n_rows, n_cols)
  )
}

ggplot(data = XX, aes(col, row)) +
  geom_tile(aes(fill = pmin(first, second))) +
  geom_text(aes(label = paste0("{", first, "," ,second, "}")), data = XX %>% filter(!is.na(first)), color = "black", size = 1) +
  geom_segment(data = grid_lines(7, 7), aes(x = x, y = y, xend = xend, yend = yend), size = .1) +
  scale_y_reverse() +
  scale_fill_gradient(low = "#cbdbbc", high = "#234702", na.value = "grey") +
  coord_fixed() +
  theme_void() +
  theme(
    legend.position  = "none"
  )

ggsave("min.png", width = 1, height = 1)

ggplot(data = XX, aes(col, row)) +
  geom_tile(aes(fill = pmax(first, second))) +
  geom_text(aes(label = paste0("{", first, "," ,second, "}")), data = XX %>% filter(!is.na(first)), color = "black", size = 1) +
  geom_segment(data = grid_lines(7, 7), aes(x = x, y = y, xend = xend, yend = yend), size = .1) +
  scale_y_reverse() +
  scale_fill_gradient(low = "#cbdbbc", high = "#234702", na.value = "grey") +
  coord_fixed() +
  theme_void() +
  theme(
    legend.position  = "none",
  )

ggsave("max.png", width = 1, height = 1)
