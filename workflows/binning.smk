####################################################
# binning.smk: MAG binning & refinement
rule metabat2:
    input: "results/assembly/{sample}.contigs.fa"
    output: directory("results/bins/metabat2/{sample}")
    shell: "metabat2 -i {input} -o {output}/{wildcards.sample} -t 16"

rule das_tool:
    input: bins=expand("results/bins/{method}/{sample}", method=["metabat2","maxbin2","concoct"], sample=config["samples"])
    output: directory("results/bins/das_tool")
    shell: "DAS_Tool -i {input.bins} -l metabat2,maxbin2,concoct -o {output}"
