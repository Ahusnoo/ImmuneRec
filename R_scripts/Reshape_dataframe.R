
library(tidyr)
library(UpSetR)
Input_file_directory <- '/home/ahusnoo/Documents/Aaisha/MPhil_PhD/2023/8.August/Haploview/AllSubpops/Haplotypes/Haplotypes_LongDataframes/'
Gene_class_list <- list('Chemokine_receptors','Hemopoietic_Cytokine_Receptors','Housekeeping_Genes','IFN_Receptors','IL_Receptors','LILRs','T_cell_receptor_AB','T_cell_receptor_DG','TGFBR','TLRs','TNFR')
for (gene_class in Gene_class_list){
	Input_file_directory <- '/home/ahusnoo/Documents/Aaisha/MPhil_PhD/2023/8.August/Haploview/AllSubpops/Haplotypes/Haplotypes_LongDataframes/'
	Input_file_path <- paste (Input_file_directory,gene_class,'_Haplotypes_DF.csv', sep ='')
	df <- read.csv (Input_file_path, header= TRUE)
	df
	new_df <- spread(df, key=Population, value=Value)
	new_df
	Output_file_path <- paste ('/home/ahusnoo/Documents/Aaisha/MPhil_PhD/2023/8.August/Haploview/AllSubpops/Haplotypes/Haplotypes_ShortDataframes/',gene_class,'_Haplotypes_ShortDataframes.csv', sep='')
	write.csv (new_df,Output_file_path,row.names = FALSE)
	x <- upset(new_df, keep.order=TRUE, main.bar.color='darkblue')
	x
}
