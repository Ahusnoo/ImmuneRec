library(ggplot2)
library(dplyr)
library(scales)

# Input file
input_file_path <- "Allreceptors_Mainpops_SNPCounts_BlockLength_ExonsLength.csv"

# Read CSV
df <- read.csv(
  input_file_path,
  header = TRUE,
  stringsAsFactors = FALSE
)

# Compute medians per gene class
median_df <- df %>%
  group_by(GeneClass) %>%
  summarise(
    Median_SNPDensity = median(SNPDensityInHaploblock, na.rm = TRUE),
    Median_BlockFraction = median(BlockLengthFraction, na.rm = TRUE)
  ) %>%
  mutate(
    Median_SNPDensity = round(Median_SNPDensity, 1),
    Median_BlockFraction = round(Median_BlockFraction, 1)
  )

# Force HGs to the far right
median_df$GeneClass <- factor(
  median_df$GeneClass,
  levels = c(sort(setdiff(median_df$GeneClass, "HGs")), "HGs")
)

# Plot 1: Median SNP Density
p_snp <- ggplot(
  median_df,
  aes(x = GeneClass, y = Median_SNPDensity, fill = GeneClass)
) +
  geom_col(width = 0.6) +
  geom_text(
    aes(label = sprintf("%.1f", Median_SNPDensity)),
    vjust = -0.5,
    size = 4,
    fontface = "bold"
  ) +
  scale_y_continuous(
    labels = label_number(accuracy = 0.1)
  ) +
  labs(
    x = "Gene Class",
    y = "Median SNP density within haploblocks"
  ) +
  theme_minimal() +
  theme(
    axis.text.x  = element_text(size = 11, face = "bold", angle = 45, hjust = 1),
    axis.text.y  = element_text(size = 14, face = "bold"),
    axis.title.x = element_text(size = 14, face = "bold"),
    axis.title.y = element_text(size = 14, face = "bold"),
    legend.position = "none"
  )

# Save SNP density plot
output_snp_path <- "Median_SNPDensity.jpg"

ggsave(
  filename = output_snp_path,
  plot = p_snp,
  width = 30,
  height = 15,
  units = "cm",
  dpi = 300
)

# Plot 2: Median Block Fraction
p_block <- ggplot(
  median_df,
  aes(x = GeneClass, y = Median_BlockFraction, fill = GeneClass)
) +
  geom_col(width = 0.6) +
  geom_text(
    aes(label = sprintf("%.1f", Median_BlockFraction)),
    vjust = -0.5,
    size = 4,
    fontface = "bold"
  ) +
  scale_y_continuous(
    labels = label_number(accuracy = 0.1)
  ) +
  labs(
    x = "Gene Class",
    y = "Percentage of exons occupied by haploblocks"
  ) +
  theme_minimal() +
  theme(
    axis.text.x  = element_text(size = 11, face = "bold", angle = 45, hjust = 1),
    axis.text.y  = element_text(size = 14, face = "bold"),
    axis.title.x = element_text(size = 14, face = "bold"),
    axis.title.y = element_text(size = 14, face = "bold"),
    legend.position = "none"
  )

# Save block fraction plot
output_block_path <- "Median_BlockFraction.jpg"

ggsave(
  filename = output_block_path,
  plot = p_block,
  width = 30,
  height = 15,
  units = "cm",
  dpi = 300
)
