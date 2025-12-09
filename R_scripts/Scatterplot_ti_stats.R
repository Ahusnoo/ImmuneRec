library(ggplot2)
library(ggrepel)

# Read CSV
data <- read.csv(
  "/home/ahusnoo/Documents/Aaisha/MPhil_PhD/FinalThesisCorrections/HaplotypeDiversity/Mainpops_SNPDensity_HDiv_normalised.csv",
  sep = ",", header = TRUE
)

# Thresholds
snp_threshold <- 0
hdiv_threshold <- 0

# Category
data$Category <- ifelse(
  data$SNP_Density > snp_threshold & data$Haplotype_Diversity < hdiv_threshold,
  "High SNP, Low HD", "Other"
)

# Plot
p <- ggplot(data, aes(x = SNP_Density, y = Haplotype_Diversity, color = Category)) +
  
  # Axes at x=0 and y=0
  geom_hline(yintercept = 0, color = "black") +
  geom_vline(xintercept = 0, color = "black") +
  
  # Show all labels (even if overlapping)
  geom_text(
    aes(label = Gene),
    size = 2,
    fontface = "bold"
  ) +
  
  scale_color_manual(values = c("High SNP, Low HD" = "red", "Other" = "blue")) +
  
  # Slightly expanded limits for better label placement
  scale_x_continuous(limits = c(-4.5, 4.5)) +
  scale_y_continuous(limits = c(-4.5, 4.5)) +
  
  # Remove legend
  theme_minimal() +
  theme(legend.position = "none") +  
  
  xlab("ti statistics (SNP Density)") +
  ylab("ti statistics (Haplotype Diversity)") +
  ggtitle("Scatter plot of Haplotype Diversity versus SNP Density (Labels Only)")

# Show plot
print(p)

# Save image
ggsave(
  filename = "/home/ahusnoo/Documents/Aaisha/MPhil_PhD/FinalThesisCorrections/HaplotypeDiversity/plot_HD_vs_SNP.jpg",
  plot = p,
  width = 8, height = 6, dpi = 300
)

