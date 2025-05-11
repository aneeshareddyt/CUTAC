#!/usr/bin/env nextflow

include { CUTADAPT } from '../modules/cutadapt.nf'

workflow HELLO_WORLD_WORKFLOW {
    /* 
    * Creates a channel emitting some string values
    */

    Channel
        .fromPath('samples.csv')  // Path to your CSV file
        .splitCsv(header: true)
        .map { row -> [ 
            [id: row.sample_id],  // Create the meta map with ID
            file(row.read_1),    // Forward read file
            file(row.read_2)     // Reverse read file
        ]}
        .set { ch_reads }

    ch_reads.view()
    println "hellow from workflow"
}