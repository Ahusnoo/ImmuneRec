df <- data.frame(
  Gene = c("TLR4","TLR6","CCR2","IL4R","IL4R","IL1RL1","CSF3R"),
  rsID = c(4986790,5743810,1799864,1805010,1801275,4988958,121918426),
  AFR = c(91.6,99.7,17.6,47.3,80.6,78,0.7),
  AMR = c(96.3,81.7,21.2,42.5,32.1,28.5,0),
  EUR = c(94.3,59.2,8.6,42.5,20.8,40.5,0),
  EAS = c(0,100,21.3,51.6,16.6,12.5,0),
  SAS = c(87.4,98.3,9.8,41.6,23.9,20.6,0)
)

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
