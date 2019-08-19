# GBS-SNP-CROP

## Description (from github page)

The GBS SNP Calling Reference Optional Pipeline (GBS-SNP-CROP) is executed via a sequence of seven Perl scripts that integrate custom parsing and filtering procedures with well-known, vetted bioinformatic tools, giving the user full access to all intermediate files. By employing a novel strategy of variant (SNPs and indels) calling based on the correspondence of within-individual to across-population patterns of polymorphism, the pipeline is able to identify and distinguish high-confidence variants from both sequencing and PCR errors, whether or not a reference genome is available. In the latter case, the pipeline adopts a clustering strategy to build a population-tailored "Mock Reference" using the same GBS data for downstream calling and genotyping. Designed for libraries of either paired-end (PE) or single-end (SE) reads of arbitrary lengths, GBS-SNP-CROP maximizes data usage by eliminating unnecessary data culling due to imposed length uniformity requirements. GBS-SNP-CROP is a complete bioinformatics pipeline developed primarily to support curation, research, and breeding programs wishing to utilize GBS for the cost-effective genome-wide characterization of plant genetic resources.

## Note

It does not support the paired end options because the software that this GBS-SNP-Crop uses for this is not free software and therefore cannot be distributed.
