rule checkm:
    input:
        bins="results/bins/das_tool/{sample}"
    output:
        summary="checkm_out/{sample}_lineage_summary.tsv"
    shell:
        "checkm lineage_wf -x fa {input.bins} checkm_tmp/{wildcards.sample} && "
        "mv checkm_tmp/{wildcards.sample}/lineage_summary.tsv {output.summary}"
