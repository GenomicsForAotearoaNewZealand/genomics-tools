# Meraculous-2D

## Description from README

Meraculous-2D Genome Assembler
 Eugene Goltsman, Isaac Ho, Jarrod Chapman, Steven Hofmeyr

 Meraculous is a whole genome assembler for Next Generation Sequencing
 data, geared for large genomes. It's hybrid k-mer/read-based
 approach capitalizes on the high accuracy of Illumina sequence
 by eschewing an explicit error correction step which we argue to be
 redundant with the assembly process.  Meraculous achieves high
 performance with large datasets by utilizing lightweight data
 structures and multi-threaded parallelization, allowing to assemble
 human-sized genomes on a high-cpu cluster in under a day. The process
 pipeline implements a highly transparent and portable model of job
 control and monitoring where different assembly stages can be
 executed and re-executed separately or in unison on a wide variety of
 architectures.

 For more information see doc/meraculous/Manual.pdf
