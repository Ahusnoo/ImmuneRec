library("chisq.posthoc.test")

Gene_class_list <- list('HighFreqHaplotype_SigDif.csv')
for (Gene_class in Gene_class_list){
	Gene_class_filepath <- paste('/HaplotypeFreq/', Gene_class, sep = '')
	Input_file <- read.csv(Gene_class_filepath, header = TRUE)
	Input_dataframe <- Input_file[, c(4,6:10)]
	for (row in 1:nrow(Input_dataframe)) {
	  Row_Names <- Input_file[row, "Row_Names"]
	  Haplotype <- Input_file[row, "Haplotype"]
	  Header <- c('Haplotype', 'AFR', 'AMR', 'EAS', 'EUR', 'SAS', 'AFR Residual', 'p value')
	  AFR_freqfraction <- Input_file[row, "AFR"]
	  AMR_freqfraction <- Input_file[row, "AMR"]
	  EAS_freqfraction <- Input_file[row, "EAS"]
	  EUR_freqfraction <- Input_file[row, "EUR"]
	  SAS_freqfraction <- Input_file[row, "SAS"]
	  AFR_freq <- AFR_freqfraction*851
	  AMR_freq <- AMR_freqfraction*347
	  EAS_freq <- EAS_freqfraction*504
	  EUR_freq <- EUR_freqfraction*503
	  SAS_freq <- SAS_freqfraction*489
	  Observed_freq <- c(AFR_freq, AMR_freq, EAS_freq, EUR_freq, SAS_freq)
	  chi_squared_test <- chisq.test(Observed_freq, p= c(851/2694, 347/2694, 504/2694, 503/2694, 489/2694))
	  Expected_freq <- chi_squared_test$expected
	  Matrix <- as.table (rbind(Observed_freq, Expected_freq))
	  dimnames(Matrix) <- list(Frequencies = c('Observed', 'Expected'), Population = c('AFR', 'AMR', 'EAS','EUR','SAS'))
	  Post_hoc_chi_squared_test <- chisq.posthoc.test(Matrix)
	  AFR_values <- Post_hoc_chi_squared_test$AFR
	  Residual_AFRObserved <- AFR_values[1]
	  Pvalue_AFRObserved <- AFR_values[2]
	  Output_line <- c(Haplotype, AFR_freqfraction, AMR_freqfraction, EAS_freqfraction, EUR_freqfraction, SAS_freqfraction, Residual_AFRObserved, Pvalue_AFRObserved)
	  Output_dataframe <- as.data.frame(Output_line)
	  Output_file_name <- paste ('/ChiSquared/', Row_Names, '.csv', sep='' )
	  write.csv(Output_dataframe, Output_file_name, row.names = FALSE)
  }
}
