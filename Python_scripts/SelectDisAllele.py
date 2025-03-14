Input_file = open('/AlleleFreq/AlleleFreq_MatchedFile_Subpops.csv','r')
Output_file = open('/AlleleFreq/AlleleFreq_DiseaseVariants_Subpops.csv','w')
I_readlines = Input_file.readlines ()
Header = I_readlines[0]
Output_file.write(Header)
Allele_info_list = I_readlines[1:] 
for l in Allele_info_list:
	rm_newline = l.strip('\n') 
	l_list = rm_newline.split('\t')
	Allele = l_list[3]
	print (Allele)
	ALLELE_str = l_list[-1]
	ALLELE = ALLELE_str[0]
	print (ALLELE)
	if Allele == ALLELE:
		Output_file.write(l)
		
Input_file.close()
Output_file.close()
