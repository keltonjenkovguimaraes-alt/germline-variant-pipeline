process FASTQC {
    tag "FASTQC on ${sample_id}"
    label 'fastqc'
    conda "${workflow.projectDir}/environment.yml"
    
    input:
    tuple val(sample_id), path(reads)
    
    output:
    path "*.html", emit: html
    path "*.zip", emit: zip
    
    script:
    """
    fastqc ${reads} --threads ${task.cpus} --outdir .
    """
}
