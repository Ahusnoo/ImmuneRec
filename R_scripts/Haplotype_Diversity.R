library(PopGenome)

GENOME.class <- readVCF(genename.vcf.gz, 10000, Chromosome, First exon start position, Last exon end position,  include.unknown = FALSE, approx = FALSE, parallel = FALSE)
div.stat <-  diversity.stats(GENOME.class)
hap.div <- div.stat@hap.diversity.within
outputfile <- write.csv(hap.div, 'haplotype_diversity_genename.csv', row.names = FALSE)
