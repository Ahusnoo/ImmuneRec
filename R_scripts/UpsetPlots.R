library(UpSetR)
library(ggplot2)

Gene_class_list <- list('Chemokine_receptors','Hemopoietic_Cytokine_Receptors','Housekeeping_Genes','IFN_Receptors','IL_Receptors','LILRs','T_cell_receptor_AB_joining','T_cell_receptor_AB_variable','T_cell_receptor_DG_joining','T_cell_receptor_DG_variable','TGBFR','TLRs','TNFR')

for (gene_class in Gene_class_list){
	Input_file_path <- paste ('/Haplotype_ShortDF/',gene_class,'_Haplotypes_ShortDF.csv', sep='')
	df <- read.csv (Input_file_path, header= TRUE)
	df
	Upset_Plot <- upset(df,
			    keep.order=TRUE,
			    mainbar.y.label="Number of haplotypes in population intersection sets",
			    main.bar.color='darkblue', matrix.color = 'darkred', sets.bar.color = 'orange', sets.x.label = 'Total Number of Haplotypes',
			    sets = c('YRI','WGR','MSL','MAL','LWK','GWD','FNB','ESN','BSZ','BRN','BOT','BBC'),
			    nsets = 12,
			    set_size.show=TRUE,
			    text.scale = c(intersection.size.title = 1.3,
					   intersection.size.tick.labels = 1.5,
					   set.size.title = 1.2,
					   set.size.tick.labels =1.5,
					   set.names= 1.3,
					   numbers.above.bars=1.6))
	
	Output_file_path <- paste ('/UpsetPlots/',gene_class,'_UpsetPlots_subpops.png', sep='')
#	ggsave (Output_file_path, width = 10, height = 10, units = "cm")
	png(Output_file_path, width = 800, height = 500)
	print (Upset_Plot)
	dev.off()
}


