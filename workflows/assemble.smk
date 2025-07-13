####################################################
# assemble.smk: Metagenome assembly
rule megahit:
    input: R1="data/raw/{sample}_R1.fastq.gz", R2="data/raw/{sample}_R2.fastq.gz"
    output: "results/assembly/{sample}.contigs.fa"
    params: k="21,33,55,77"
    threads: 16
    shell: "megahit -1 {input.R1} -2 {input.R2} --k-list {params.k} -t {threads} -o results/assembly/{wildcards.sample}"
