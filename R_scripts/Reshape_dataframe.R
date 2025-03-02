library(tidyr)

Gene_class_list <- list('Chemokine_receptors','Hemopoietic_Cytokine_Receptors','Housekeeping_Genes','IFN_Receptors','IL_Receptors','LILRs','T_cell_receptor_AB_joining','T_cell_receptor_AB_variable','T_cell_receptor_DG_joining','T_cell_receptor_DG_variable','TGBFR','TLRs','TNFR')

for (gene_class in Gene_class_list){
	Input_file_directory <- '/Haplotypes_LongDataframes/'
	Input_file_path <- paste (Input_file_directory,gene_class,'_Haplotypes_DF.csv', sep ='')
	df <- read.csv (Input_file_path, header= TRUE)
	new_df <- spread(df, key=Population, value=Value)
	Output_file_path <- paste ('/Haplotypes_ShortDataframes/',gene_class,'_Haplotypes_ShortDataframes.csv', sep='')
	write.csv (new_df,Output_file_path,row.names = FALSE)
}
