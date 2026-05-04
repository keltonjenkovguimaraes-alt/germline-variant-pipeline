process MULTIQC {
    tag "Generate report"
    conda "${workflow.projectDir}/environment.yml"
    publishDir "${params.outdir}/multiqc", mode: 'copy'
    
    input:
    path fastqc_results
    path alignment_stats
    
    output:
    path "multiqc_report.html"
    path "multiqc_data/"
    
    script:
    """
    multiqc . --force
    """
}
