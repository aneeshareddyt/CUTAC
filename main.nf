#!/usr/bin/env nextflow 

nextflow.enable.dsl = 2

/**
* include workflow
*/
include { HELLO_WORLD_WORKFLOW } from './workflows/helloworld'

/*
* named workflows
*/
workflow HELLO_WORLD {  
    println "Starting hello world workflow"
    HELLO_WORLD_WORKFLOW()
    println "Ended hello world workflow"
}


/*
* call the main workflow
*/
workflow {
    HELLO_WORLD()
}