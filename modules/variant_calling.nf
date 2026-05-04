process VARIANT_CALLING {
    tag "Variant call ${sample_id}"
    conda "${workflow.projectDir}/environment.yml"
    publishDir "${params.outdir}/variants", mode: 'copy'
    
    input:
    tuple val(sample_id), path(bam), path(bai), path(reference)
    
    output:
    path "${sample_id}.vcf.gz", emit: vcf
    path "${sample_id}.vcf.gz.csi", emit: csi
    path "${sample_id}.stats.txt"
    
    script:
    """
    bcftools mpileup -f ${reference} ${bam} -Ou | bcftools call -mv -Ov -o ${sample_id}.vcf
    bgzip -c ${sample_id}.vcf > ${sample_id}.vcf.gz
    bcftools index ${sample_id}.vcf.gz
    bcftools stats ${sample_id}.vcf.gz > ${sample_id}.stats.txt
    """
}
