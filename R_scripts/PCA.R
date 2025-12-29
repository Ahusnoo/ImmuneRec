library(ggplot2)
library(dplyr)
library(ggrepel)

df <- read.csv(
  "Obs_Exp_Standardise.csv",
  stringsAsFactors = FALSE
)

rownames(df) <- df$Gene

# PCA variables (already standardised)
pca_vars <- df %>%
  select(
    SNP_density,
    Haplotype_Diversity,
    LD,
    Tajima_D
  )

# PCA
pca <- prcomp(pca_vars, center = FALSE, scale. = FALSE)

# PCA scores
scores <- as.data.frame(pca$x[, 1:2])
scores$Gene <- rownames(scores)

# Merge biological variables
scores <- scores %>%
  left_join(
    df %>%
      select(
        Gene,
        TajimaD_raw,
        Standardised_Hdiv,
        Standardised_SNPDensity,
        LD_standardised
      ),
    by = "Gene"
  )

# Define selection regimes
scores$SelectionRegime <- "Neutrality"

scores$SelectionRegime[
  scores$LD_standardised < 0 &
    scores$Standardised_Hdiv < -0.3 &
    scores$Standardised_SNPDensity < 0 &
    scores$TajimaD_raw < 0 &
    scores$TajimaD_raw > -2
] <- "Purifying selection"

scores$SelectionRegime[
  scores$TajimaD_raw > 2 &
    scores$Standardised_Hdiv > -0.3 &
    scores$Standardised_SNPDensity > 0 &
    scores$LD_standardised < 0
] <- "Balancing selection"

scores$SelectionRegime[
  scores$TajimaD_raw < -2 &
    scores$LD_standardised < 0 &
    scores$Standardised_Hdiv < -0.3
] <- "Directional selection"

scores$SelectionRegime <- factor(
  scores$SelectionRegime,
  levels = c(
    "Neutrality",
    "Purifying selection",
    "Balancing selection",
    "Directional selection"
  )
)

# PCA loadings
loadings <- as.data.frame(pca$rotation[, 1:2])
loadings$Variable <- rownames(loadings)

# Subsets for plotting
neutral_data <- scores %>% filter(SelectionRegime == "Neutrality")
balancing_data <- scores %>% filter(SelectionRegime == "Balancing selection")
directional_data <- scores %>% filter(SelectionRegime == "Directional selection")

# PCA plot
ggplot(scores, aes(PC1, PC2)) +
  
# Neutral genes (points)
geom_point(
  data = neutral_data,
  aes(colour = SelectionRegime),
  size = 1.3,
  alpha = 0.5
) +
  
# Balancing selection (labels only)
geom_text_repel(
  data = balancing_data,
  aes(label = Gene, colour = SelectionRegime),
  size = 3.5,
  fontface = "bold",
  box.padding = 0.35,
  point.padding = 0.25,
  max.overlaps = Inf
) +
  
# Directional selection (labels only)
geom_text_repel(
  data = directional_data,
  aes(label = Gene, colour = SelectionRegime),
  size = 3.5,
  fontface = "bold",
  box.padding = 0.35,
  point.padding = 0.25,
  max.overlaps = Inf
) +
  
# PCA loadings
geom_segment(
  data = loadings,
  aes(
    x = 0, y = 0,
    xend = PC1 * 4,
    yend = PC2 * 4
  ),
  arrow = arrow(length = unit(0.2, "cm")),
  colour = "black",
  inherit.aes = FALSE
) +
  
  geom_text(
    data = loadings,
    aes(
      x = PC1 * 4.2,
      y = PC2 * 4.2,
      label = Variable
    ),
    size = 3,
    inherit.aes = FALSE
  ) +
  
# Manual colours + legend
scale_colour_manual(
  values = c(
    "Neutrality" = "red",
    "Balancing selection" = "darkblue",
    "Directional selection" = "darkgreen",
    "Purifying selection" = "orange"
  ),
  drop = FALSE
) +
  
  theme_bw() +
  labs(
    title = "PCA of genetic diversity metrics with selection regime classification",
    x = paste0(
      "PC1 (",
      round(summary(pca)$importance[2, 1] * 100, 1),
      "%)"
    ),
    y = paste0(
      "PC2 (",
      round(summary(pca)$importance[2, 2] * 100, 1),
      "%)"
    ),
    colour = "Selection regime"
  ) +
  theme(
    legend.position = "right",
    plot.title = element_text(hjust = 0.5)
  )
