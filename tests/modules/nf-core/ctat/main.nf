#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { CTAT } from '../../../../modules/nf-core/ctat/main.nf'

workflow test_ctat {

    input = [
        [ id:'test' ], // meta map
        [
            file(params.test_data['homo_sapiens']['illumina']['test_umi_1_fastq_gz'], checkIfExists: true),
            file(params.test_data['homo_sapiens']['illumina']['test_umi_2_fastq_gz'], checkIfExists: true)
        ]
    ]
    //fasta_1  = file(params.test_data['homo_sapiens']['genome']['genome_fasta'], checkIfExists: true)
    //fasta_2  = file(params.test_data['homo_sapiens']['genome']['genome_fasta'], checkIfExists: true)
    //sample_id = '1234'
    //outputdir = '/tmp/'

    //CTAT ( fasta_1, fasta_2, sample_id, outputdir )
    CTAT ( input )
}
