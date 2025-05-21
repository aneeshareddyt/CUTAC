process CUTADAPT {
    time = '1d'
    cpus = 6
    memory = '36G'
    module = ['cutadapt/4.9-GCCcore-12.3.0']


    tag "CUTADAPT on ${meta.id}"

    publishDir "${params.out_dir}/", pattern: '*.txt', mode: 'copy'

    input:
    tuple val(meta), path(read1), path(read2)
    

    output:
    tuple val(meta), path("hello_${read1.simpleName}.txt"), path("hello_${read2.simpleName}.txt"), emit: fq
    tuple val(meta), path( "${meta.id}.cutadapt.json" ), emit: js

    script:
    def args = task.ext.args ?: ""
    """
    echo "hello, ${args}, ${read1}" > hello_${read1.simpleName}.txt
    echo "hello, ${args}, ${read2}" > hello_${read2.simpleName}.txt
    """
}