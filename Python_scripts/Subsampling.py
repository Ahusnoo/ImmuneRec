import os
import random

# === CONFIGURATION ===
input_folder = "/Subsampling/R2/Populations/"       # Folder with 5 input files
output_folder = "/Subsampling/R2/Population_Subsamples/"       # Folder to save the 50 subsample files
n_subsamples = 50                 # Number of subsamples per input file
subsample_size = 50               # Number of individuals per subsample

# === Create output folder if it doesn't exist ===
os.makedirs(output_folder, exist_ok=True)

# === Process each input file ===
for filename in os.listdir(input_folder):

    # Read sample IDs from input file
    filepath = os.path.join(input_folder, filename)
    with open(filepath, "r") as f:
        sample_ids = [line.strip() for line in f if line.strip()]

    if len(sample_ids) < subsample_size:
        print(f"Skipping {filename}: only {len(sample_ids)} samples, need at least {subsample_size}")
        continue

    base_name = os.path.splitext(filename)[0]

    # Create 50 subsamples
    for i in range(n_subsamples):
        subsample = random.sample(sample_ids, subsample_size)  # sample without replacement
        output_filename = f"{base_name}_subsample_{i+1}.txt"
        output_path = os.path.join(output_folder, output_filename)

        with open(output_path, "w") as out_f:
            for sample in subsample:
                out_f.write(sample + "\n")

    print(f"Processed {filename}: generated {n_subsamples} subsamples.")

print("✅ All subsamples generated.")
