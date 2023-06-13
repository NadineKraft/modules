#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { CTAT } from '../../../../modules/nf-core/ctat/main.nf'

workflow test_ctat {
    
    input = [
        [ id:'test', single_end:false ], // meta map
        file(params.test_data['sarscov2']['illumina']['test_paired_end_bam'], checkIfExists: true)
    ]

    CTAT ( input )
}
