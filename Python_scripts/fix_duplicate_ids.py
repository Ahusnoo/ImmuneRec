import os

#open and read map_file
input_dir = '/ped_map/'
output_dir = '/missing_var_fixed/'
gene_class_list = os.listdir(input_dir)

for gene_class in gene_class_list:
	gene_class_dir = input_dir + gene_class +'/'
	files_list = os.listdir(gene_class_dir)
	for filename in files_list:
		if filename.endswith('.map'):
			i_filepath = gene_class_dir + filename
			input_file = open(i_filepath,'r')
			input_file_readlines = input_file.readlines()

#open output file
			o_filepath = output_dir + gene_class +'/' + filename
			output_file = open(o_filepath,'w')

#replace missing variant ids by chr:pos 
			out_list = []
			for line in input_file_readlines:
				rm_newline = line.strip('\n')
				line_list = rm_newline.split('\t')
				Chr = line_list[0]
				pos = line_list[3]
				var_ID = line_list[1]
				if var_ID == '.':
					chr_pos = Chr + ':' + pos
					new_var_ID = var_ID.replace('.',chr_pos)
					output_line =  Chr + '\t' + new_var_ID + '\t0\t' + pos + '\n'
					out_list.append(output_line)
				else:
					output_line =  Chr + '\t' + var_ID + '\t0\t' + pos + '\n'
					out_list.append(output_line)

#identify and modify duplicate variant ids
			unique_out_list = list(set(out_list))
			sorted_list = sorted(unique_out_list, key=lambda x: x.split('\t0\t')[-1])
		
			for e in sorted_list:
				count = out_list.count(e)
				if count == 1:
					output_file.write(e)	
				elif count > 1:
					indices = []
					for a in range(len(out_list)):
						if out_list[a] == e:
							indices.append(a)
					for i in indices:
						j = out_list[i]
						e_list = j.split('\t')  
						Chromosome = e_list[0]
						dup_ID = e_list[1]
						position = e_list[3]
						index = indices.index(i)
						new_index = index + 1
						new_ID = dup_ID + 'a' + str(new_index)
						output_line1 = Chromosome + '\t' + new_ID + '\t0\t' + position
						output_file.write(output_line1)
			input_file.close()
			output_file.close()
			


