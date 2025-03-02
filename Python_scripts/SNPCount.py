import os

dir = '/SNPDensity/output/'
g_list = os.listdir(dir)
for g in g_list:
	idir = dir + g + '/'
	ofile_path = '/SNPDensityProcessing/'+ g + '_SNPCount.csv'
	ofile = open(ofile_path,'w')
	header = 'GeneName,SNPCount,Population\n'
	ofile.write(header)
	ifile_list = os.listdir(idir)
	for file_name in ifile_list:
		rm_pop = file_name [13:]
		find_pos = rm_pop.find('_')
		gene_name = rm_pop [:find_pos]
		ifile_path = idir + file_name
		i_file = open (ifile_path,'r')
		i_file_data = i_file.readlines()
		SNP_count_list = []
		for line in i_file_data:
			line_list = line.split('\t')
			SNP = line_list[2]
#Count number of SNPs in .freq file from VCFtools
			if SNP == '1':
				SNP_int = int(SNP)
				SNP_count_list.append(SNP_int)
				Total_SNP_count = sum(SNP_count_list)
				str_Total_SNP_count = str(Total_SNP_count)
		output_line = gene_name + ',' + str_Total_SNP_count + ',' + 'Baylor_AFR\n'
		ofile.write (output_line)
		
		i_file.close()
	ofile.close()
