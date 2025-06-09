#!/bin/bash

# Set paths
MAIN_DIR="/GeneticDiversity/Subsampling/R3/VCFs/recode"
OUTPUT_DIR="/GeneticDiversity/Subsampling/R3/SNPCount"

mkdir -p "$OUTPUT_DIR"

# Loop over each subfolder
for subfolder in "$MAIN_DIR"/*/; do
    subfolder_name=$(basename "$subfolder")

    # Loop over each subsubfolder
    for subsubfolder in "$subfolder"*/; do
        subsubfolder_name=$(basename "$subsubfolder")
        output_file="$OUTPUT_DIR/${subfolder_name}_${subsubfolder_name}_snp_counts.csv"

        # Start a fresh output file
        > "$output_file"

        # Process each VCF file
        for vcf in "$subsubfolder"/*.vcf; do  # note: changed from .vcf.gz to .vcf
            [ -e "$vcf" ] || continue  # Skip if no files

            snp_count=$(cat "$vcf" | awk '
                BEGIN { count = 0 }
                $0 !~ /^#/ {
                    for (i = 10; i <= NF; i++) {
                        split($i, a, ":")
                        if (a[1] ~ /1/) {
                            count++
                            break
                        }
                    }
                }
                END { print count }
            ')
            
            vcf_filename=$(basename "$vcf")
            echo -e "$vcf_filename\t$snp_count" >> "$output_file"
        done
    done
done
