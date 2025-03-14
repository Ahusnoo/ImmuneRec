AlleleFreq_file = open('/AlleleFreq/All_AID_variants_shortDF_Subpops.csv','r')
AF_readlines = AlleleFreq_file.readlines()

Variant_List_File = open ('/AlleleFreq/SingleNucleotideVariant.csv','r')
VL_readlines = Variant_List_File.readlines()

Output_file = open('/AlleleFreq/AlleleFreq_MatchedFile_Subpops.csv','w')
Header =  'Allele_ID	Chromosome	Position	Allele	BBC	BOT	BRN	BSZ	ESN	FNB	GWD	LWK	MAL	MSL	WGR	YRI	Mutation	Phenotype	Clinical Significance	rsID\n'
Output_file.write(Header)

for l in AF_readlines:
	rm_newline = l.strip('\n')
	l_list = rm_newline.split(',')
	id = l_list[0]
	chr = l_list[1]
	pos = l_list[2]
	allele = l_list[3]
	BBC = l_list[4]
	BOT = l_list[5]
	BRN = l_list[6]
	BSZ = l_list [7]
	ESN = l_list [8]
	FNB = l_list [9]
	GWD = l_list [10]
	LWK = l_list [11]
	MAL = l_list [12]
	MSL = l_list [13]
	WGR = l_list [14]
	YRI = l_list [15]
	for L in VL_readlines:
		L_list = L.split('\t')
		ALLELE_ID = L_list[0]
		CHR = L_list[18]
		START = L_list[19]
		MUTATION = L_list[2]
		CLIN_SIG = L_list[6]
		RSID = L_list[9]
		PHENOTYPE = L_list[13]
		findpos = MUTATION.find('>')
		ALLELE = MUTATION[findpos+1:findpos+2]
		if id == ALLELE_ID:
			output_line = id + '\t' + chr + '\t' + pos + '\t' + allele + '\t' + BBC + '\t' + BOT + '\t' + BRN + '\t' + BSZ + '\t' + ESN +'\t' + FNB + '\t' + GWD + '\t' + LWK + '\t' + MAL + '\t' + MSL + '\t' + WGR + '\t' + YRI + '\t' + MUTATION + '\t' + PHENOTYPE + '\t' + CLIN_SIG + '\t' + RSID + '\t' + ALLELE + '\n'
			Output_file.write(output_line)
			
AlleleFreq_file.close()
Variant_List_File.close()
Output_file.close()





