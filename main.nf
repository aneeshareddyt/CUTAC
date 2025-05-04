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

}


/*
* call the main workflow
*/
workflow {
    HELLO_WORLD()
}