# Load required libraries
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)

# 1. Read input CSV (header present)

fst <- read_csv(
  "/home/ahusnoo/Documents/Aaisha/MPhil_PhD/FinalThesisCorrections/Chapter6-7/Fst/R1/VCFs/recode_variants/Fst_results_merged_TLR6.csv",
  show_col_types = FALSE
)

# 2. Split population pairs
fst <- fst %>%
  separate(Comparison, into = c("Pop1", "Pop2"), sep = "_vs_")

# 3. Create full symmetric population matrix
pops <- sort(unique(c(fst$Pop1, fst$Pop2)))

fst_full <- expand_grid(Pop1 = pops, Pop2 = pops) %>%
  left_join(fst, by = c("Pop1", "Pop2")) %>%
  left_join(
    fst %>% rename(Pop1 = Pop2, Pop2 = Pop1),
    by = c("Pop1", "Pop2"),
    suffix = c("", ".rev")
  ) %>%
  mutate(Fst = coalesce(Fst, Fst.rev, 0)) %>%
  select(Pop1, Pop2, Fst)

# 4. Keep lower triangle only
fst_plot <- fst_full %>%
  mutate(
    Pop1 = factor(Pop1, levels = pops),
    Pop2 = factor(Pop2, levels = pops)
  ) %>%
  filter(as.numeric(Pop1) >= as.numeric(Pop2))

# 5. Plot heatmap (fixed Fst scale 0–1)
p <- ggplot(fst_plot, aes(x = Pop2, y = Pop1, fill = Fst)) +
  geom_tile(color = "white") +
  geom_text(aes(label = round(Fst, 3)), size = 4) +
  scale_fill_gradient(
    name = "Pairwise Fst",
    low = "red",
    high = "steelblue",
    limits = c(0, 1),
    oob = squish
  ) +
  coord_fixed() +
  theme_minimal(base_size = 14) +
  theme(
    axis.title = element_blank(),
    axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid = element_blank()
  )

# 6. Save figure
ggsave(
  filename = "pairwise_Fst_heatmap_TLR6.png",
  plot = p,
  width = 7,
  height = 6,
  dpi = 300
)

