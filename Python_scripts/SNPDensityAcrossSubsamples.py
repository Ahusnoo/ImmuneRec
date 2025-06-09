import os
import csv

# Set this to your desired input and output directories
input_dir = '/GeneticDiversity/Subsampling/R3/SNPCount'
output_dir = '/GeneticDiversity/Subsampling/R3/SNPDensity/'
os.makedirs(output_dir, exist_ok=True)

# Mapping from gene set name to total SNP count
gene_total_snps = {
    "Chemokine_receptors": 85813,
    "Hemopoietic_Cytokine_Receptors": 85294,
    "IFN_Receptors": 40569,
    "IL_Receptors": 189590,
    "LILRs": 36825,
    "T_cell_receptor_AB_Joining": 508,
    "T_cell_receptor_AB_Variable": 33824,
    "T_cell_receptor_DG_Joining": 101,
    "T_cell_receptor_DG_Variable": 5834,
    "TGBFR": 31954,
    "TLRs": 53239,
    "TNFR": 123077
}

# Process each *_snp_counts.csv file
for filename in os.listdir(input_dir):
    if filename.endswith('_snp_counts.csv'):
        for gene_name, total_snps in gene_total_snps.items():
            if gene_name in filename:
                input_path = os.path.join(input_dir, filename)
                output_path = os.path.join(output_dir, filename.replace('.csv', '_with_norm.csv'))

                with open(input_path, 'r') as infile, open(output_path, 'w', newline='') as outfile:
                    reader = csv.reader(infile, delimiter=',')  # Use comma as the delimiter
                    writer = csv.writer(outfile, delimiter=',')

                    for row in reader:
                        print(f"Processing row: {row}")  # Debug: check the row format
                        try:
                            # Assuming SNP count is in the second column (index 1)
                            snp_count = int(row[1])
                            normalized = (snp_count / total_snps) * 1000
                            writer.writerow(row + [f"{normalized:.6f}"])
                        except (IndexError, ValueError) as e:
                            print(f"Error processing row {row}: {e}")  # Debug: catch errors
                            writer.writerow(row + ["NA"])

                print(f"Saved normalized file to: {output_path}")
