========
Tutorial
========


Step 1: Build docker image:
```
docker build -t active-enhancers .
```
Step 2: Make data directory and download example data from GSE43835:
```
mkdir data

docker run --rm -v "$(pwd)":/data -w /data active-enhancers fastq-dump -Z SRR653421 --stdout --gzip > GRO-seq_Vehicle_rep1.fastq.gz
docker run --rm -v "$(pwd)":/data -w /data active-enhancers fastq-dump -Z SRR653422 --stdout --gzip > GRO-seq_Vehicle_rep2.fastq.gz
docker run --rm -v "$(pwd)":/data -w /data active-enhancers fastq-dump -Z SRR653423 --stdout --gzip > GRO-seq_E2_10m_rep1.fastq.gz
docker run --rm -v "$(pwd)":/data -w /data active-enhancers fastq-dump -Z SRR653424 --stdout --gzip > GRO-seq_E2_10m_rep2.fastq.gz
docker run --rm -v "$(pwd)":/data -w /data active-enhancers fastq-dump -Z SRR653425 --stdout --gzip > GRO-seq_E2_40m_rep1.fastq.gz
docker run --rm -v "$(pwd)":/data -w /data active-enhancers fastq-dump -Z SRR653426 --stdout --gzip > GRO-seq_E2_40m_rep2.fastq.gz
```
Step 3: Run fastqc on all the files:
```
docker run --rm -v "$(pwd)":/data -w /data active-enhancers /scripts/quality-metric-fastqc.sh -f GRO-seq_Vehicle_rep1.fastq.gz
docker run --rm -v "$(pwd)":/data -w /data active-enhancers /scripts/quality-metric-fastqc.sh -f GRO-seq_Vehicle_rep2.fastq.gz
docker run --rm -v "$(pwd)":/data -w /data active-enhancers /scripts/quality-metric-fastqc.sh -f GRO-seq_E2_10m_rep1.fastq.gz
docker run --rm -v "$(pwd)":/data -w /data active-enhancers /scripts/quality-metric-fastqc.sh -f GRO-seq_E2_10m_rep2.fastq.gz
docker run --rm -v "$(pwd)":/data -w /data active-enhancers /scripts/quality-metric-fastqc.sh -f GRO-seq_E2_40m_rep1.fastq.gz
docker run --rm -v "$(pwd)":/data -w /data active-enhancers /scripts/quality-metric-fastqc.sh -f GRO-seq_E2_40m_rep2.fastq.gz
```
