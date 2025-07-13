####################################################
# qc.smk: Quality control
rule fastqc:
    input: "data/raw/{sample}_R1.fastq.gz", "data/raw/{sample}_R2.fastq.gz"
    output: "results/fastqc/{sample}_R1.html", "results/fastqc/{sample}_R2.html"
    shell: "fastqc {input} -o results/fastqc/"

rule multiqc:
    input: expand("results/fastqc/{sample}_R1.html", sample=config["samples"])
    output: "results/multiqc_report.html"
    shell: "multiqc results/fastqc/ -o results/"
