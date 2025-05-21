process CUTADAPT {
    time = '1d'
    cpus = 6
    memory = '36G'
    module = ['cutadapt/4.9-GCCcore-12.3.0']


    tag "CUTADAPT on ${meta.id}"

    publishDir "${params.out_dir}/trimmed_fastq/", pattern: '*.gz', mode: 'copy'

    input:
    tuple val(meta), path(read1), path(read2)
    

    output:
    tuple val(meta), path("${read1.simpleName}_trimmed.fastq.gz"), path("${read2.simpleName}_trimmed.fastq.gz"), emit: fq
    tuple val(meta), path( "${meta.id}.cutadapt.json" ), emit: js

    script:
    def args = task.ext.args ?: ""
    """
    cutadapt -j ${task.cpus} \
    --json=${meta.id}.cutadapt.json \
        --nextseq-trim=20 \
        -m 20 \
        --overlap 3 \
        -o ${read1.simpleName}_trimmed.fastq.gz \
    -p ${read2.simpleName}_trimmed.fastq.gz \
    $args \
    $read1 $read2
    """
}