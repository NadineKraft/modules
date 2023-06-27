process CTAT {
    tag "$meta.id"
    label 'process_medium'

    conda "bioconda::ctat-mutations=2.1.0"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/ctat-mutations:2.0.1--py27_4':
        'biocontainers/ctat-mutations:2.0.1--py27_4' }"

    input:
    tuple val(meta), path(left), path(right), val (outputdir), val (sample_id)


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


    """
    ctat_mutations \\
        --left ${fasta_1} \\
        --rigth ${fasta_2} \\
        --sample_id \\
        --outputdir \\
        ${args}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        ctat: \$( echo \$(ctat_mutations --version 2>&1 | tr -d '[:cntrl:]' ) | sed -e 's/^.*Version: //;s/\\[.*\$//')
    END_VERSIONS
    """
}
