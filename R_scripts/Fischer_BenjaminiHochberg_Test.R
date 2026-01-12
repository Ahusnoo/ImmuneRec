#Read input CSV file
input_file <- "allele_frequencies.csv"
df <- read.csv(input_file, header = TRUE, stringsAsFactors = FALSE)

# Sample sizes (diploid)
sample_sizes <- c(
  AFR = 597,
  AMR = 347,
  EUR = 503,
  EAS = 504,
  SAS = 489
)

# Fisher's exact test function
run_fisher <- function(freq_afr, freq_other, n_afr, n_other) {

  # Convert frequencies to allele counts
  afr_alt <- round((freq_afr / 100) * 2 * n_afr)
  afr_ref <- 2 * n_afr - afr_alt

  oth_alt <- round((freq_other / 100) * 2 * n_other)
  oth_ref <- 2 * n_other - oth_alt

  # 2x2 contingency table
  tbl <- matrix(
    c(afr_alt, afr_ref,
      oth_alt, oth_ref),
    nrow = 2,
    byrow = TRUE
  )

  fisher.test(tbl)
}

# Run AFR vs AMR/EUR/EAS/SAS
results <- data.frame()

for (i in 1:nrow(df)) {

  for (pop in c("AMR","EUR","EAS","SAS")) {

    test <- run_fisher(
      freq_afr   = df$AFR[i],
      freq_other = df[[pop]][i],
      n_afr      = sample_sizes["AFR"],
      n_other    = sample_sizes[pop]
    )

    results <- rbind(
      results,
      data.frame(
        Gene = df$Gene[i],
        rsID = df$rsID[i],
        Comparison = paste("AFR vs", pop),
        OddsRatio = unname(test$estimate),
        Pvalue = test$p.value
      )
    )
  }
}

# Multiple testing correction
results$FDR <- p.adjust(results$Pvalue, method = "BH")

# Save results
write.csv(results, "AFR_vs_Others_FishersExact_results.csv", row.names = FALSE)
