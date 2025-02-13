library(ggplot2)

input_file_path <- "/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Merge_samples/MainPops/SNPDensity/Mainpops/Long_DF_SNPDensity_allreceptors.csv"
graph_title <- ""
df <- read.csv(input_file_path, header = TRUE)
ggplot(df, aes(x = Population, y = SNPDensity, fill=Population)) + geom_boxplot(notch=FALSE) + labs(title=graph_title,
        x ="Populations", y = "SNP density (SNPs per Kb)")
output_file_path <- "/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Merge_samples/MainPops/SNPDensity/Boxplots/AllReceptors.png"
ggsave (output_file_path, width = 10, height = 15, units = c("cm"))
