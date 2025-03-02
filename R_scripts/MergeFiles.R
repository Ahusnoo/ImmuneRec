library(data.table)

Gene_Class_list <- list('Chemokine_receptors','Hemopoietic_Cytokine_Receptors','Housekeeping_Genes','IFN_Receptors','IL_Receptors','LILRs','T_cell_receptor_AB_joining','T_cell_receptor_AB_variable','T_cell_receptor_DG_joining','T_cell_receptor_DG_variable','TGBFR','TLRs','TNFR')

for (Gene_Class in Gene_Class_list){
	input_file_directory = paste('/SNPDensity/', Gene_Class,sep='')
	file_list <- list.files(input_file_directory, pattern="*.csv", full.names=TRUE)
	ldf <- lapply(file_list , read.csv)
	df.combined <- do.call(rbind, ldf)
	output_file_location = paste(Gene_Class,'_SNPDensity_mainpops.csv' ,sep="")
	write.csv(df.combined,output_file_location, row.names = FALSE)
}
