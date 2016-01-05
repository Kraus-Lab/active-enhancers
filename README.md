# active-enhancers
Identifying active enhancers and well known transcritption factor binding sites from GRO-seq data.

[![Build Status](https://travis-ci.org/Kraus-Lab/active-enhancers.svg?branch=master)](https://travis-ci.org/Kraus-Lab/active-enhancers)

## Contributors
- [Anusha Nagari](https://github.com/anaga2)
- [Venkat Malladi](https://github.com/vsmalladi)

## Docker Image
Docker Image to analyze GRO-seq data.

### Requirements
- [docker](https://docs.docker.com/installation/)

### Included tools and software:

 * [R 3.0.2](www.r-project.org/)
 * [Python 2.7.2](https://www.python.org/)
 * [Perl v5.18.2](https://www.perl.org)
 * [fastqc 0.10.1](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
 * [cutadapt 1.2.1](http://cutadapt.readthedocs.org/en/stable/index.html)
 * [BWA 0.7.12](http://bio-bwa.sourceforge.net)
 * [samtools 0.1.19](http://samtools.sourceforge.net/)
 * [bedtools 2.17.0](http://bedtools.readthedocs.org/en/latest/)
 * [groHMM](http://www.bioconductor.org/packages/release/bioc/html/groHMM.html)
 * [SRA Tools 2.5.4](https://github.com/ncbi/sra-tools)

### Included data:

Data is downloaded from [GSE43835](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE43835).

This experiment looks at GRO-seq data from MCF-7 human breast cancer cells in response to short time course of E2 treatment (10min, 40min)
and no treatment (Veh).

### Usage

At first you need to install docker. Please follow the instruction on https://docs.docker.com/installation/

After the successful installation, please follow the online tutorial if you haven't used DOCKER before: https://training.docker.com/introduction-to-docker.

# Download data using sra-tools

# Mount data

### TODO

- Add in tutorial for scripts
