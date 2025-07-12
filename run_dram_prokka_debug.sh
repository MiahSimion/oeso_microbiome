#!/bin/bash
# Enable debugging output
set -x

echo "Starting DRAM processing for Prokka annotations..."
PROKKA_DIR="/home/jovyan/shared-team/Prokka_Annotations"
DRAM_OUT="/home/jovyan/shared-team/dram_output_prokka"

# Check if the Prokka annotations directory exists
if [ ! -d "$PROKKA_DIR" ]; then
    echo "Error: Directory $PROKKA_DIR does not exist."
    exit 1
fi

# Create the output directory for DRAM results
mkdir -p "$DRAM_OUT"

# Loop through each subdirectory in the Prokka annotations folder
for dir in "$PROKKA_DIR"/*; do
    if [ -d "$dir" ]; then
        binname=$(basename "$dir")
        echo "Processing bin: $binname"
        
        # Search recursively for any file ending in .faa (case-sensitive)
        faa_file=$(find "$dir" -type f -name "*.faa" | head -n 1)
        
        if [ -z "$faa_file" ]; then
            echo "Warning: No .faa file found in $dir"
        else
            echo "Found FASTA file: $faa_file"
            outdir="$DRAM_OUT/$binname"
            rm -rf "$outdir"  # Remove any existing output directory
            echo "Running DRAM for bin: $binname, output to $outdir"
            DRAM.py annotate_genes -i "$faa_file" -o "$outdir"
        fi
    else
        echo "$dir is not a directory."
    fi
done