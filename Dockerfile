###############################################################
# Dockerfile to build container images to test active-enhancers
# Based on Ubuntu
###############################################################

FROM ubuntu:14.04

MAINTAINER Venkat Malladi <Venkat.Malladi@utsouthwestern.edu>


# Install wget and unzip
RUN  apt-get update \
  && apt-get install -y wget unzip git

# R
RUN apt-get -y install r-base

# Install Python
RUN apt-get install -y python2.7 python2.7-dev python-pip libcurl4-openssl-dev

# Install Perl

# Install FastQC
RUN apt-get install -y openjdk-7-jre
RUN apt-get install -y fastqc=0.10.1+dfsg-2

# Install cutadapt
RUN pip install cutadapt==1.2.1

# Install BWA
RUN git clone https://github.com/lh3/bwa && \
	cd bwa && \
	git checkout 0.7.12 &&  \
	make && cp bwa /usr/local/bin/bwa

# Install samtools
RUN apt-get install -y samtools=0.1.19-1

# Install bedtools
RUN apt-get install -y bedtools=2.17.0-1

# Install groHMM
RUN Rscript -e "source('http://bioconductor.org/biocLite.R'); biocLite("BiocUpgrade"); biocLite('groHMM')"

# Install SRA Tool
RUN wget "http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.5.4-1/sratoolkit.2.5.4-1-ubuntu64.tar.gz" && \
    tar -zxfv sratoolkit.2.5.4-1-ubuntu64.tar.gz && \
    cp -r sratoolkit.2.5.4-1-ubuntu64/bin/* /usr/local/bin && \

# Clean up
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/ \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
    && rm -fr sratoolkit.2.5.4-1-ubuntu64/ \
    && rm -fr bwa/

# Add scripts
ADD scripts /scripts

# Setup directory to download data
RUN mkdir /data
WORKDIR /data

# Download example data from GSE43835
fastq-dump -A SRR653421 --stdout --gzip > GRO-seq_Vehicle_rep1.fastq.gz
fastq-dump -A SRR653422	--stdout --gzip > GRO-seq_Vehicle_rep2.fastq.gz
fastq-dump -A SRR653423 --stdout --gzip > GRO-seq_E2_10m_rep1.fastq.gz
fastq-dump -A SRR653424 --stdout --gzip > GRO-seq_E2_10m_rep2.fastq.gz
fastq-dump -A SRR653425 --stdout --gzip > GRO-seq_E2_40m_rep1.fastq.gz
fastq-dump -A SRR653426 --stdout --gzip > GRO-seq_E2_40m_rep2.fastq.gz

WORKDIR /
