library(PopGenome)

GENOME.class <- readVCF("/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Merge_samples/Baylor_AFR/HapDiv_vcfs/output/IFN_Receptors/Baylor_1KAFR_IFNAR1_all_exons.vcf.gz", 10000,"21", 33324387, 33359864, include.unknown=FALSE, approx=FALSE, parallel=FALSE)
neutrality_stats <- neutrality.stats(GENOME.class)
Tajima <- neutrality_stats@Tajima.D
outputfile <-write.csv(Tajima, "/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Merge_samples/Baylor_AFR/Tajima/output/IFN_Receptors/Baylor_1KAFR_IFNAR1_Tajima.csv", row.names = FALSE)
