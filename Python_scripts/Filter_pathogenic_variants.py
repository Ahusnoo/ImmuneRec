gene_list = ['CCR7',  'EPOR',  'LILRA5',  'CCR4',  'CXCR4',  'ACKR2',  'GPR17',  'IL12RB1',  'IL18RAP',  'IL1R1',  'LIFR',  'TGFBR3L',  'TLR5',  'TNFRSF10B',  'TNFRSF6B',  'ACKR4',  'CNTFR',  'TNFRSF10C']

with open('/home/ahusnoo/Documents/Aaisha/MPhil_PhD/AutoimmuneDiseases/Pathogenic_variants_only/variant_summary_2023-06/variant_summary.txt', 'r') as ClinVarInputFile, open('/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Merge_samples/MainPops/GenesStrongSelection_Diseases.txt', 'w') as ClinVarOutputFile:
	ClinVar_file_readlines = ClinVarInputFile.readlines()
	Header = ClinVar_file_readlines[0]
	Output_header = Header.strip('\n')
	ClinVarOutputFile.write(Header)
	for LINE in ClinVar_file_readlines:
		RM_NEWLINE = LINE.strip('\n')
		LINE_LIST = RM_NEWLINE.split('\t')
		CLINICAL_SIGNIFICANCE = LINE_LIST[6]
		GENE_SYMBOL = LINE_LIST[4]
		CHROMOSOME_REF = LINE_LIST[16]
		if CHROMOSOME_REF == 'GRCh38':
			if CLINICAL_SIGNIFICANCE == 'Pathogenic' or  CLINICAL_SIGNIFICANCE == 'Likely pathogenic' or CLINICAL_SIGNIFICANCE == 'Pathogenic/Likely pathogenic' or CLINICAL_SIGNIFICANCE == 'protective' or  CLINICAL_SIGNIFICANCE == 'risk factor' or  CLINICAL_SIGNIFICANCE == 'association':
				if GENE_SYMBOL in gene_list:
					ClinVarOutputFile.write(LINE)
			
			
ClinVarInputFile.close()
ClinVarOutputFile.close()	
