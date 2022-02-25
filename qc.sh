#!/bin/bash

#cat checksums.md5 | parallel -j4 --pipe -N1 md5sum -c

ls *fastq.gz | parallel -j4 fastqc {}
multiqc .
