process CTAT {
    tag "$meta.id"
    label 'process_medium'

    conda "bioconda::ctat-mutations=2.0.1"
    //conda "bioconda/noarch::ctat-mutations-2.0.1-py27_1"

    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/ctat-mutations:2.0.1--py27_4':
        'biocontainers/ctat-mutations:2.0.1--py27_4' }"

    input:
    tuple val(meta), path(fasta_1), path(fasta_2)
    //tuple val(meta), path(reads)


    output:
    tuple val(meta), path("*.variants.HC_init.wAnnot.vcf"),           emit: initial_variants
    tuple val(meta), path("*.variants.HC_hard_cutoffs_applied.vcf "), emit: hard_cutoffs_variants
    tuple val(meta), path("*.cancer.vcf"),                            emit: cancer_variants
    tuple val(meta), path("*.igvjs_viewer.html"),                     emit: html

    path "versions.yml"           , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    def VERSION = '2.0.1' // WARN: Version information not provided by tool on CLI. Please update this string when bumping container versions.

    //def sample_id = args.contains("--sample_id") ? "" : "--sample_id ${prefix}"
    def outputdir = args.contains("--out_dir") ? "" : "--out_dir ${prefix}"




    """
    ctat_mutations \\
        --left ${fasta_1} \\
        --right ${fasta_2} \\
        ${outputdir} \\
        ${args}


    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        ctat_mutations: $VERSION
    END_VERSIONS
    """

}
