library(ggplot2)
library(PMCMRplus)
library(rcompanion)
library(readr)
library(FSA)
gene_class_list <- list ('Chemokine_receptors','Hemopoietic_Cytokine_Receptors','Housekeeping_Genes','IFN_Receptors','IL_Receptors','LILRs','T_cell_receptor_AB_joining','T_cell_receptor_AB_ variable','T_cell_receptor_DG_joining','T_cell_receptor_DG_variable','TGBFR','TLRs','TNFR')
for (gene_class in gene_class_list){
  input_file_path <- paste("/SNPDensity/",gene_class,"_SNPDensity_mainpops.csv",sep = "")
  df <- read.csv(input_file_path, header = TRUE)
  #get mean, median, quartile values
  data_summary <- tapply(df$SNPDensity, df$Population, summary)
  data_summary
  #kruskal wallis test
  Kruskal_Wallis <- kruskal.test(SNPDensity ~ Population, data=df)
  Kruskal_Wallis
  df$Population <- as.factor(df$Population)
  #Dunn's test
  DT = dunnTest(SNPDensity ~ Population, data=df, method="bh")
  DT
  PT = DT$res
  PT
  Grouping <- cldList(P.adj ~ Comparison, data = PT, threshold = 0.05)
#  DTT =PMCMRTable(DT)
#  DTT
#  Grouping <- cldList(p.value ~ Comparison, data=DTT)
#  Grouping
  Output <- c("AFR, AMR, EAS, EUR, SAS", '\n', data_summary,'\n', Kruskal_Wallis,'\n', Grouping)
  output_file_path <- paste("/KruskalWallis/",gene_class,".txt",sep = "")
  writeLines(as.character(Output), output_file_path)
}
