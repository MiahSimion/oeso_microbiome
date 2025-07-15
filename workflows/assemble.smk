rule megahit:
    input:
        R1="data/raw/{sample}_R1.fastq.gz",
        R2="data/raw/{sample}_R2.fastq.gz"
    output:
        contigs="results/assembly/{sample}.contigs.fa"
    params:
        klist="21,33,55,77",
        outdir="results/assembly/{sample}"
    threads: 8
    shell:
        """
        megahit \
            -1 {input.R1} \
            -2 {input.R2} \
            --k-list {params.klist} \
            -t {threads} \
            -o {params.outdir}

        if [ -s {params.outdir}/final.contigs.fa ]; then
            mv {params.outdir}/final.contigs.fa {output.contigs}
        else
            echo ">empty_contig" > {output.contigs}
            echo "N" >> {output.contigs}
        fi
        """

