#!/bin/bash
# Loop over each Prokka annotation folder and run DRAM

# Define input and output directories
PROKKA_DIR="/home/jovyan/shared-team/prokka_annotations"
DRAM_OUT="/home/jovyan/shared-team/dram_output_prokka"

# Create the output directory if it doesn't exist
mkdir -p "$DRAM_OUT"

# Loop through each subdirectory in the Prokka annotations folder
for dir in "$PROKKA_DIR"/*; do
    if [ -d "$dir" ]; then
        binname=$(basename "$dir")
        echo "Processing bin: $binname"
        
        # Find the first .faa file in this directory (change *.faa if needed)
        faa_file=$(find "$dir" -maxdepth 1 -type f -name "*.faa" | head -n 1)
        
        if [ -z "$faa_file" ]; then
            echo "Warning: No .faa file found in $dir"
        else
            echo "Found FASTA file: $faa_file"
            outdir="$DRAM_OUT/$binname"
            rm -rf "$outdir"  # Remove old output directory if it exists
            echo "Running DRAM on $binname..."
            DRAM.py annotate_genes -i "$faa_file" -o "$outdir"
        fi
    fi
done
