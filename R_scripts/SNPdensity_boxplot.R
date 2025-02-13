library(ggplot2)

gene_class_list <- list ('Chemokine_receptors','Hemopoietic_Cytokine_Receptors','Housekeeping_Genes','IFN_Receptors','IL_Receptors','LILRs','T_cell_receptor_AB_joining','T_cell_receptor_AB_ variable','T_cell_receptor_DG_joining','T_cell_receptor_DG_variable','TGBFR','TLRs','TNFR')
for (gene_class in gene_class_list){
  input_file_path <- paste("/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Merge_samples/MainPops/SNPDensity/Mainpops/",gene_class,"_SNPDensity_mainpops.csv",sep = "")
  df <- read.csv(input_file_path, header = TRUE)
  ggplot(df, aes(x = Population, y = SNPDensity, fill=Population)) + geom_boxplot(notch=FALSE) + labs(y = "SNP density (SNPs per Kb)", axis.text.x=element_text(size=15), axis.text.y=element_text(size=15))
  output_file_path <- paste("/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Merge_samples/MainPops/SNPDensity/Boxplots/",gene_class,".png",sep = "")
  ggsave (output_file_path, width = 15, height = 15, units = c("cm"))
}
