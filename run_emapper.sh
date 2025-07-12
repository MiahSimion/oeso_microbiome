#!/bin/bash

# Set directories
PROKKA_DIR="/shared/team/Prokka_Annotations"
OUTPUT_DIR="/shared/team/Functional_Annotations"
EGGNOG_DB="/shared/team/eggnog_db"
TMP_DIR="/shared/team/tmp"

# Ensure output and temp directories exist
mkdir -p "$OUTPUT_DIR"
mkdir -p "$TMP_DIR"

# Number of CPUs to use
CPU=8

# Loop through all MAGs
for MAG in "$PROKKA_DIR"/*; do
    if [[ -d "$MAG" ]]; then  # Check if it's a directory (a MAG folder)
        
        # Extract the bin name
        BIN_NAME=$(basename "$MAG")
        FAA_FILE="$MAG/${BIN_NAME}.faa"
        
        # Define output file
        OUTPUT_PREFIX="$OUTPUT_DIR/${BIN_NAME}.emapper"

        # Check if the annotation has already been done
        if [[ -f "${OUTPUT_PREFIX}.annotations" ]]; then
            echo "Skipping ${BIN_NAME}, already processed."
            continue
        fi

        # Run EggNOG-mapper
        echo "Running EggNOG-mapper for $BIN_NAME..."
        emapper.py -i "$FAA_FILE" \
                   -o "$OUTPUT_PREFIX" \
                   --cpu $CPU \
                   --data_dir "$EGGNOG_DB" \
                   --temp_dir "$TMP_DIR"

        echo "Finished processing $BIN_NAME."
    fi
done

echo "All MAGs processed!"
