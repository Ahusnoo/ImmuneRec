import os

Input_directory = '/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Merge_samples/Baylor_AFR/Haploview/Haploview_Outputs/output/'
Gene_class_directory_list = os.listdir(Input_directory)
for Gene_class_directory in Gene_class_directory_list:
	Input_file_directory =  Input_directory + Gene_class_directory + '/GABRIELblocks/'
	Output_file_directory = '/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Merge_samples/Baylor_AFR/Haploview/Haplotype_Freq/HapFreq_PerGene/' + Gene_class_directory + '/'
	Check_file_directory = Input_directory + Gene_class_directory + '/CHECK/'	
	Input_files_list = os.listdir(Input_file_directory)
	for Input_file_name in Input_files_list:
		Input_file_location = Input_file_directory + Input_file_name
		rm_fileExtension = Input_file_name[:-14]
		Check_filename = rm_fileExtension + '.CHECK'
		Output_filename = rm_fileExtension + '_Haplotypes.csv'
		Output_file_location = Output_file_directory + Output_filename
		Output_file = open(Output_file_location, 'w')
		Header = 'Population' + ',' + 'GeneName' + ',' + 'Haplotype' + ',' + 'Frequency' + ',' + 'Receptor Class' + '\n'
		Output_file.write(Header)
		Input_file = open(Input_file_location,'r')
		pop_name = Input_file_name [:12]
#		pop_name = Input_file_name [:6]
		find_dot_pos = Input_file_name.find('.')
		gene_name = Input_file_name[13:find_dot_pos]

		Input_file_data = Input_file.readlines()
		length_list = len(Input_file_data)
		for line in Input_file_data:
			Recombination = line.startswith('Multiallelic')
			if Recombination == True:
				Input_file_data.remove(line)

		sublist_index_list = []
		for line in Input_file_data:
			if 'BLOCK' in line:
				Block_index = Input_file_data.index(line)
				sublist_index_list.append(Block_index)

		length_list1 = len(Input_file_data)	

		sublist_index_list.append(length_list1)

		for i in range (0,len(sublist_index_list)-1):
			j = i+1
			Sublist = Input_file_data[sublist_index_list[i]:sublist_index_list[j]]
			Markers = Sublist[0]
			Markers_rmNewline = Markers.strip('\n')
			Find_Markers = Markers_rmNewline.find(':')
			Markers_string = Markers_rmNewline[Find_Markers+2:]
			Markers_list = Markers_string.split(' ')
			for x in range(len(Sublist)-1):
				y = x+1
				Haplotypes = Sublist[y]
				HF_Start = Haplotypes.find('(')
				HF_End = Haplotypes.find(')')
				Haplotype_Output = Haplotypes[0:HF_Start-1]
				Haplotype_Freq = Haplotypes[HF_Start+1:HF_End]
				MARKERS_LIST = []
				for MARKER_NO in Markers_list:
					Check_file_location = Check_file_directory + Check_filename
					Check_file = open (Check_file_location, 'r')
					Check_file_data = Check_file.readlines()
					for LINE in Check_file_data:
						rm_newline = LINE.strip('\n')
						LINE_list = rm_newline.split('\t')
						Marker_No = LINE_list[0]
						Marker_position = LINE_list[2]
						if MARKER_NO == Marker_No:
							MARKERS_LIST.append(Marker_position)
					Check_file.close()
				MARKERS_str = ','.join(MARKERS_LIST)
				MARKERS_str_new = MARKERS_str.replace(',',' ')
				Output = pop_name + ',' + gene_name + ',' + gene_name + ' ' + MARKERS_str_new + ' ' + Haplotype_Output + ',' + Haplotype_Freq + ',' + Gene_class_directory + '\n'
				Output_file.write(Output)

		Input_file.close()
		Output_file.close()
		
		
