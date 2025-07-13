rule quast:
    input: contigs="results/assembly/{sample}.contigs.fa"
    output: html="results/quast/{sample}.html"
    shell: "quast {input.contigs} -o results/quast/{wildcards.sample}"
