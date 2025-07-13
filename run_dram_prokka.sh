#!/usr/bin/env bash
# Loop over each Prokka annotation folder and run DRAM

# 1) Set the Prokka annotations directory (adjust if yours differs)
PROKKA_DIR="results/prokka"

# 2) Set where you want DRAM outputs
DRAM_OUT="results/dram_prokka"

# 3) Make sure the output directory exists
mkdir -p "${DRAM_OUT}"

# 4) Iterate over each sample’s Prokka folder
for dir in "${PROKKA_DIR}"/*; do
  if [[ -d "$dir" ]]; then
    binname=$(basename "$dir")
    echo "Processing bin: $binname"

    # 5) Find the .faa file (Prodigal output) in that folder
    faa_file=$(find "$dir" -maxdepth 1 -type f -name "*.faa" | head -n 1)
    if [[ -z "$faa_file" ]]; then
      echo "Warning: No .faa file found in $dir"
      continue
    fi

    echo "Found FASTA file: $faa_file"
    outdir="${DRAM_OUT}/${binname}"

    # 6) Remove any old output for this bin
    rm -rf "${outdir}"

    # 7) Run DRAM annotate+distill
    echo "Running DRAM on $binname..."
    DRAM.py annotate -i "${faa_file}" -o "${outdir}/annotate"
    DRAM.py distill -i "${outdir}/annotate/annotations.tsv" -o "${outdir}/distill"
  fi
done
