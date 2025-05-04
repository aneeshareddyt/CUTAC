#!/usr/bin/env nextflow

/* 
 * Creates a channel emitting some string values
 */
 
str = Channel.from('hello', 'hola', 'bonjour', 'ciao')

/*
 * Creates a process which declares the channel `str` as an input
 * Each value emitted by the channel triggers the execution 
 * of the process. The process stdout is caputured and send over 
 * the channel `result`  
 */
 
process printHello {

   input:
   val str 

   output: 
   stdout into result

   """
   echo $str
   """
}	

/*
 * Subscribes the channel `result` and print the 
 * emitted value each time a value is available
 */ 
 
result.println()