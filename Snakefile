configfile: "config.yaml"

configfile: "config.yaml"

configfile: "config.yaml"

configfile: "config.yaml"

rule all:
    input:
        expand("results/quast/{sample}.html", sample=config["samples"]),
        "checkm_out/lineage_summary.tsv"

include: "workflows/qc.smk"
include: "workflows/assemble.smk"
include: "workflows/binning.smk"
include: "workflows/annotation.smk"
include: "workflows/quast.smk"
include: "workflows/checkm.smk"
