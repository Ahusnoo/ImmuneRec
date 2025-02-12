import pandas as pd
import os

input_directory = '/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Merge_samples/Baylor_AFR/missing_var_fixed/'
input_directory_list = os.listdir(input_directory)

for GeneClass in input_directory_list:
	input_pedmapfile_directory = input_directory + GeneClass + '/'
		
	output_pedmapfile_directory = '/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Merge_samples/Baylor_AFR/rm_del/' + GeneClass + '/'
	
	input_pedmapfile_list = os.listdir(input_pedmapfile_directory)
	for input_file_name in input_pedmapfile_list:
		if  input_file_name.endswith('.ped'):
			input_pedfile_path = input_pedmapfile_directory + input_file_name
			rm_extension_ped = input_file_name[:-4]
			input_pedfile = open (input_pedfile_path,'r')
			input_pedfile_df = pd.read_csv(input_pedfile, header = None, delimiter = ' ')
		
			input_mapfile_path = input_pedmapfile_directory + rm_extension_ped + '.map'
			input_mapfile = open (input_mapfile_path,'r')
			input_mapfile_data = input_mapfile.readlines()
		
			output_pedfile_path = output_pedmapfile_directory + rm_extension_ped + '_nodel.ped'
			output_pedfile = open (output_pedfile_path, 'w')
		
			output_mapfile_path = output_pedmapfile_directory + rm_extension_ped + '_nodel.map'
			output_mapfile = open (output_mapfile_path, 'w')
		
			Individual_info = input_pedfile_df.iloc[:, 0:6]
			Individual_info_df = pd.DataFrame(Individual_info)
			Genotypes = input_pedfile_df.iloc[:, 6:]
		

			Column_numbers = len(input_mapfile_data)*2

			for i in range (0,Column_numbers,2):
				line_in_map_file = i//2
				df_column1_index = i
				df_column2_index = i + 1
				genotype_column1 = Genotypes.iloc[:, df_column1_index]
				genotype_column1_df = pd.DataFrame(genotype_column1)
				genotype_column2 = Genotypes.iloc[:, df_column2_index]
				genotype_column2_df = pd.DataFrame(genotype_column2)
				genotype_columns = pd.concat([genotype_column1_df,genotype_column2_df],axis='columns')
				col1_values = genotype_column1.values
				col2_values = genotype_column2.values
				if '*'  not in col1_values and '*' not in col2_values:
					new_pedfile_df = pd.concat([Individual_info_df, pd.DataFrame(genotype_columns)], axis='columns')	
					Individual_info_df = new_pedfile_df
					output_mapfile.write(input_mapfile_data[line_in_map_file])
			Individual_info_df.to_csv(output_pedfile, sep=' ', index=False, header=False)	
		
			input_pedfile.close()
			input_mapfile.close()
			output_pedfile.close()
			output_mapfile.close()



