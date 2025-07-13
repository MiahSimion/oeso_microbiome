####################################################
# binning.smk: MAG binning & refinement

rule metabat2:
    input:
        contigs="results/assembly/{sample}.contigs.fa"
    output:
        directory("results/bins/metabat2/{sample}")
    shell:
        "metabat2 -i {input.contigs} -o {output}/{wildcards.sample} -t 16"

rule maxbin2:
    input:
        contigs="results/assembly/{sample}.contigs.fa"
    output:
        directory("results/bins/maxbin2/{sample}")
    shell:
        "run_MaxBin.pl -contig {input.contigs} -out {output}/{wildcards.sample} -thread 16"

rule concoct:
    input:
        contigs="results/assembly/{sample}.contigs.fa"
    output:
        directory("results/bins/concoct/{sample}")
    shell:
        "concoct --composition_file {input.contigs} -b {output} --threads 16"

rule das_tool:
    input:
        metabat2="results/bins/metabat2/{sample}",
        maxbin2="results/bins/maxbin2/{sample}",
        concoct="results/bins/concoct/{sample}"
    output:
        directory("results/bins/das_tool/{sample}")
    params:
        methods="metabat2,maxbin2,concoct"
    shell:
        "DAS_Tool -i {input.metabat2},{input.maxbin2},{input.concoct} -l {params.methods} -o {output}"

rule extract_faa:
    input:
        bins="results/bins/das_tool/{sample}/{sample}.fa"
    output:
        faa="results/bins/das_tool/{sample}/{sample}.faa"
    shell:
        "grep -A1 '^>' {input.bins} | sed '/^\\--/d' > {output.faa}"
