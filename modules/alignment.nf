process ALIGNMENT {
    tag "Align ${sample_id}"
    label 'alignment'
    conda "${workflow.projectDir}/environment.yml"
    publishDir "${params.outdir}/aligned", mode: 'copy'
    
    input:
    tuple val(sample_id), path(reads), path(reference)
    
    output:
    path "${sample_id}.bam", emit: bam
    path "${sample_id}.bam.bai", emit: bai
    path "${sample_id}.flagstat.txt"
    
    script:
    """
    bwa index ${reference}
    bwa mem -t ${task.cpus} ${reference} ${reads} | samtools view -bS - > ${sample_id}.bam
    samtools sort -@ ${task.cpus} ${sample_id}.bam -o ${sample_id}.sorted.bam
    mv ${sample_id}.sorted.bam ${sample_id}.bam
    samtools index ${sample_id}.bam
    samtools flagstat ${sample_id}.bam > ${sample_id}.flagstat.txt
    """
}
