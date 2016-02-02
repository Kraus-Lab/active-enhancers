========
Tutorial
========


Step 1: Build docker image:
```
    docker build -t active-enhancers .
```
Step 2: Run fastqc on all the files:
```
    docker run --rm active-enhancers /scripts/quality-metric-fastqc.sh -f /data/GRO-seq_Vehicle_rep1.fastq.gz
    docker run --rm active-enhancers /scripts/quality-metric-fastqc.sh -f /data/GRO-seq_Vehicle_rep2.fastq.gz
    docker run --rm active-enhancers /scripts/quality-metric-fastqc.sh -f /data/GRO-seq_E2_10m_rep1.fastq.gz
    docker run --rm active-enhancers /scripts/quality-metric-fastqc.sh -f /data/GRO-seq_E2_10m_rep2.fastq.gz
    docker run --rm active-enhancers /scripts/quality-metric-fastqc.sh -f /data/GRO-seq_E2_40m_rep1.fastq.gz
    docker run --rm active-enhancers /scripts/quality-metric-fastqc.sh -f /data/GRO-seq_E2_40m_rep2.fastq.gz
```
