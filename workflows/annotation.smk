####################################################
# annotation.smk: Prokka, DRAM & DRAM distill
rule prokka:
    input: "results/bins/das_tool/{sample}.fa"
    output: directory("results/prokka/{sample}")
    shell: "prokka --kingdom Bacteria --cpus 8 --outdir {output} --prefix {wildcards.sample} {input}"

rule dram:
    input: "results/prokka/{sample}/{sample}.tsv"
    output: directory("results/dram/{sample}")
    shell: "DRAM.py annotate -i {input} -o {output} && DRAM.py distillate -i {output}/annotations.tsv -o results/dram_distill/{wildcards.sample}"
