####################################################
# annotation.smk: Prokka, DRAM & DRAM distill

rule prokka:
    input:
        binfa="results/bins/das_tool/{sample}/{sample}.fa"
    output:
        dir="results/prokka/{sample}"
    threads: 8
    shell:
        "prokka --kingdom Bacteria --cpus {threads} --outdir {output.dir} --prefix {wildcards.sample} {input.binfa}"

rule dram_annotate:
    input:
        gff="results/prokka/{sample}/{sample}.gff"
    output:
        dir="results/dram/{sample}"
    shell:
        "DRAM.py annotate -i {input.gff} -o {output.dir}"

rule dram_distill:
    input:
        annot="results/dram/{sample}/annotations.tsv"
    output:
        distill="results/dram_distill/{sample}/distilled_tables.tsv"
    shell:
        "DRAM.py distillate -i {input.annot} -o results/dram_distill/{wildcards.sample}"
