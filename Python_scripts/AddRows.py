import os

idir = '/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Merge_samples/Baylor_AFR/SNPDensity/SNPDensityProcessing/SNPDenCalc/'
file_list = os.listdir(idir)
for ifilename in file_list:
	ifilepath = idir + ifilename
	ifile = open(ifilepath,'r')
	ofilepath = '/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Merge_samples/Baylor_AFR/SNPDensity/SNPDensityProcessing/AddRows/' + ifilename
	ofile = open(ofilepath,'w')
	header = 'Gene,Population,SNPDensity\n'
	ifiledata = ifile.readlines()
	gene_pop_list = []
	for line in ifiledata:
		rm_newline = line.strip('\n')
		line_list = rm_newline.split(',')
		gene = line_list[0]
		value = line_list[1]
		pop = line_list[2]
		gene_pop = gene + ',' + pop
		gene_pop_value = gene_pop + ',' + value + '\n'
		ofile.write(gene_pop_value)
		gene_pop_list.append(gene_pop)
	rm_ext = ifilename [:-15]
	gene_names_filepath = '/home/ahusnoo/Documents/Aaisha/MPhil_PhD/2023/4.April/GeneNamesPerClass/' + rm_ext + '.txt'
	gene_names_file = open(gene_names_filepath,'r')
	gene_names_data = gene_names_file.readlines()
	GENE_POP_LIST = []
	for LINE in gene_names_data:
		GENE = LINE.strip('\n')
		GENE_POP = GENE + ',Baylor_AFR'
		if GENE_POP not in gene_pop_list:
			output_line = GENE_POP + ',' + '0\n'
			ofile.write(output_line)
	
	ofile.close()
	ifile.close()
	gene_names_file.close()

