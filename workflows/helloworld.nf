#!/usr/bin/env nextflow

include { CUTADAPT } from '../modules/cutadapt.nf'

workflow HELLO_WORLD_WORKFLOW {
    /* 
    * Creates a channel emitting some string values
    */

    if (params.input_dir == null) {
        log.error "Please provide an input directory using --input"
        exit 1
    }

    // Automatically locate the samples.csv in the input folder if not specified
    if (params.sample_sheet == null) {
        params.sample_sheet = "${params.input_dir}/samples.csv"
        
        // Check if the file exists
        csv_file = file(params.sample_sheet)
        if (!csv_file.exists()) {
            log.error "Cannot find samples.csv in input directory: ${params.sample_sheet}"
            log.error "Please provide a sample sheet.csv file with --sample_sheet or ensure samples.csv exists in the input directory"
            exit 1
        }
    }   

    log.info """
    =================================================
    CUTADAPT WORKFLOW
    =================================================
    Input folder : ${params.input_dir}
    Samples CSV  : ${params.sample_sheet}
    Output dir   : ${params.outdir}
    =================================================
    """

    Channel
        .fromPath(params.sample_sheet)  // Path to your CSV file
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