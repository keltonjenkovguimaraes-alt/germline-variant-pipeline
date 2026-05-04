#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { FASTQC } from './modules/fastqc.nf'
include { ALIGNMENT } from './modules/alignment.nf'
include { VARIANT_CALLING } from './modules/variant_calling.nf'
include { MULTIQC } from './modules/multiqc.nf'

reference_ch = Channel.fromPath(params.reference)

Channel
    .fromFilePairs(params.reads, size: 2)
    .set { read_pairs_ch }

workflow {
    FASTQC(read_pairs_ch)
    alignment_ch = ALIGNMENT(read_pairs_ch, reference_ch)
    VARIANT_CALLING(alignment_ch, reference_ch)
    MULTIQC(FASTQC.out.html.collect(), alignment_ch.collect{ it[0] + ".flagstat.txt" })
}

workflow.onComplete {
    println "\n========================================="
    println "Pipeline execution completed"
    println "========================================="
    println "Results saved to: ${params.outdir}"
    println "Duration: ${workflow.duration}"
    println "Status: ${workflow.success ? 'SUCCESS' : 'FAILED'}"
    println "=========================================\n"
}
