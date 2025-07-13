configfile: "config.yaml"

configfile: "config.yaml"

configfile: "config.yaml"

configfile: "config.yaml"

include: "workflows/qc.smk"
include: "workflows/assemble.smk"
include: "workflows/binning.smk"
include: "workflows/annotation.smk"
include: "workflows/quast.smk"
include: "workflows/checkm.smk"
configfile: "config.yaml"

rule all:
    input:
        expand("results/quast/{sample}.html", sample=config["samples"]),
        expand("checkm_out/{sample}_lineage_summary.tsv", sample=config["samples"])
