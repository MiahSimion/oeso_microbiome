rule checkm:
    input: bins="results/bins/das_tool/{sample}"
    output: summary="checkm_out/lineage_summary.tsv"
    shell: "checkm lineage_wf -x fa {input.bins} checkm_out && cp checkm_out/lineage_summary.tsv {output.summary}"
