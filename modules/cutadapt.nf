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
    tuple val(meta), path("output_cutadapt/${read1.name}"), path("output_cutadapt/${read2.name}"), emit: fq
    tuple val(meta), path( "${meta.id}.cutadapt.json" ), emit: js

    script:
    def args = task.ext.args ?: ""
    """
    mkdir -p output_cutadapt
    cutadapt -j ${task.cpus} \
    --json=${meta.id}.cutadapt.json \
            --nextseq-trim=20 \
            -m 20 \
            --overlap 3 \
            -o output_cutadapt/${read1.name} \
    -p output_cutadapt/${read2.name} \
    $args \
    $read1 $read2
    """

    log.info """
    =================================================
    CUTADAPT WORKFLOW
    =================================================
    script : 
    Samples CSV  : ${params.sample_sheet}
    read1 : ${read1}
    read2 : ${read2}
    read1.name: ${read1.name}
    read2.name: ${read2.name}
    args: ${task.ext.args}
    publishdir: ${params.out_dir}/trimmed_fastq/
    script       : mkdir output_cutadapt
    cutadapt -j ${task.cpus} \
    --json=${meta.id}.cutadapt.json \
		--nextseq-trim=20 \
		-m 20 \
		--overlap 3 \
		-o output_cutadapt/$read1 \
    -p output_cutadapt/$read2 \
    $args \
    $read1 $read2
    =================================================
    """
}