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
