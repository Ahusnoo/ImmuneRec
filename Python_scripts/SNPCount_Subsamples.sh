#!/bin/bash

vcf_dir="/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Subsampling/R2/VCF_Subsamples"
outdir="/home/ahusnoo/Documents/Aaisha/MPhil_PhD/GeneticDiversity/Subsampling/R2/SNPCount"

mkdir -p "$outdir"

# Initialize CSVs
for pop in ESN GWD LWK MSL YRI; do
    echo "filename,snp_count" > "${outdir}/${pop}_snp_counts.csv"
done

# Loop over VCFs in the specified directory
for vcf in "$vcf_dir"/*.vcf.gz; do
    [[ -e "$vcf" ]] || continue

    echo "Processing $vcf..."

    prefix=$(basename "$vcf" | cut -d'_' -f1)

    case $prefix in
        ESN|GWD|LWK|MSL|YRI)
            # Count SNPs where at least one sample has a 1 (alternate allele)
            snp_count=$(zcat "$vcf" | awk '
                BEGIN { count = 0 }
                $0 !~ /^#/ {
                    for (i = 10; i <= NF; i++) {
                        if ($i ~ /1/) {
                            count++
                            next  # move to next line after first match
                        }
                    }
                }
                END { print count }
            ')
            echo "$(basename "$vcf"),${snp_count}" >> "${outdir}/${prefix}_snp_counts.csv"
            ;;
        *)
            echo "Skipping: $vcf (prefix not recognized)"
            ;;
    esac
done
