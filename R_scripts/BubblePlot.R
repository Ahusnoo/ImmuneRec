library(ggplot2)

df <- read.csv('HapDiv_SNPDen_NegDi.csv', header = TRUE)
ggplot(df, aes(x = Gene, y = Haplotype_Diversity, size = SNPDensity, color = Population)) + geom_point(alpha = 1) + scale_size(range = c(0, 6), name = "SNP Density") + theme(axis.text.x = element_text(face="bold", size=8, angle= 30), legend.position="bottom")
o_file_path <- paste('/NegDi_HDiv.png', sep='')
ggsave (o_file_path, width = 35, height = 15, units = c("cm"))

	
	

