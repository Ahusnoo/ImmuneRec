library(PopGenome)

GENOME.class <- readVCF("/Input_vcf/genename.vcf.gz", 10000,Chromosome, First exon start position, Last exon end position,  include.unknown = FALSE, approx = FALSE, parallel = FALSE)
neutrality_stats <- neutrality.stats(GENOME.class)
Tajima <- neutrality_stats@Tajima.D
outputfile <-write.csv(Tajima, "/Output_Tajima/tajima.csv", row.names = FALSE)
