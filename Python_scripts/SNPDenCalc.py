import os

Exon_length_file = open('/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Merge_samples/ExonLengthPerGene/Total_Exon_Length_AllGenes.txt','r')
Exon_length_file_data = Exon_length_file.readlines()

idir = '/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Merge_samples/Baylor_AFR/SNPDensity/SNPDensityProcessing/SNPCount/'
file_list = os.listdir(idir)
for file_name in file_list:
	ifile_path = idir + file_name
	ifile = open(ifile_path,'r')
	rm_ext = file_name[:-9]
	ofile_path = '/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Merge_samples/Baylor_AFR/SNPDensity/SNPDensityProcessing/SNPDenCalc/' + rm_ext + 'Density.csv'
	ofile = open(ofile_path,'w')
	header = 'Gene,SNPDensity,Population\n'
	ofile.write(header)
	ifile_data = ifile.readlines()
	SNP_counts_list = ifile_data[1:]
	for line in SNP_counts_list:
		line_list = line.split(',')
		gene_name = line_list [0]
		SNP_count = line_list [1]
		population = line_list[2]
		int_SNP_count = int(SNP_count)
		for LINE in Exon_length_file_data:
			RM_NEWLINE = LINE.strip('\n')
			LINE_LIST = RM_NEWLINE.split('\t')
			GENE_NAME = LINE_LIST[0]
			TOTAL_EXON_LENGTH = LINE_LIST[1]
			int_TOTAL_EXON_LENGTH = int(TOTAL_EXON_LENGTH)
			if GENE_NAME == gene_name:
				SNPDensity = (int_SNP_count/int_TOTAL_EXON_LENGTH)*1000
				str_SNPDensity = str(SNPDensity)
				output_line = gene_name + ',' + str_SNPDensity + ',' + population
				ofile.write(output_line)
			
	ifile.close()
	ofile.close()
Exon_length_file.close()
