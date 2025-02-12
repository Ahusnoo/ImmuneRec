library(data.table)

Gene_Class_list <- list('Chemokine_receptors','Hemopoietic_Cytokine_Receptors','Housekeeping_Genes','IFN_Receptors','IL_Receptors','LILRs','T_cell_receptor_AB','T_cell_receptor_DG','TGBFR','TLRs','TNFR')

for (Gene_Class in Gene_Class_list){
	input_file_directory = paste('/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Merge_samples/MainPops/SNPDensity/', Gene_Class,sep='')
	file_list <- list.files(input_file_directory, pattern="*.csv", full.names=TRUE)
	ldf <- lapply(file_list , read.csv)
	df.combined <- do.call(rbind, ldf)
	output_file_location = paste('/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Merge_samples/MainPops/SNPDensity/',Gene_Class,'_SNPDensity_mainpops.csv' ,sep="")
	write.csv(df.combined,output_file_location, row.names = FALSE)
}
