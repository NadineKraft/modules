#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { CTAT } from '../../../../modules/nf-core/ctat/main.nf'

workflow test_ctat {

    input = [
        [id:'test'], // meta map
        [
            file(params.test_data['homo_sapiens']['illumina'].test2_1_fastq_gz, checkIfExists: true)
        ],
        [
            file(params.test_data['homo_sapiens']['illumina'].test2_2_fastq_gz, checkIfExists: true)
        ]
    ]

    CTAT ( input )
}
