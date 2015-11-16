#!/bin/bash
# align-bwa.sh

script_name="align-bwa.sh"
script_ver="1.0.0"

# Help function
usage() {
  echo "Aligning to the reference genome:"
  echo ""
  echo "A maximum of two mismatches and a subsequence seed length of 32 bp are used as parameters for alignment in this step."
  echo "The ‘samse’ command will produce an output with a maximum of one alignment per read."
  echo "The final reads passing these criteria are aligned to the reference genome and are written to a sam file."
  echo ""
  echo "Converting aligned files from sam to bam format:"
  echo "The files containing the aligned reads are converted to bam from sam format to perform subsequent transcript calling."
  echo ""
  echo ""
  echo "-h Help documentation for $script_name"
  echo "-f  --Trimmed fastq file"
  echo "-i  --Genome Index"
  echo "-v  --Version of script"
  echo "Example: ./$script_name -i hg19_genome_index.fa  -f inputfile.noPolyA.noAdapt.fastq.gz"
  exit 1
}

# Version function
version(){
    echo "$script_name $script_ver"
    exit 1
}

main(){

    # Parsing options
    OPTIND=1 # Reset OPTIND
    while getopts :f:ivh opt
        do
            case $opt in
                f) input_file=$OPTARG;;
                i) genome_index=$OPTARG;;
                v) version;;
                h) usage;;
            esac
        done

    shift $(($OPTIND -1))

    # Check for mandatory options
    if [[ -z $input_file ]] || [[ -z $genome_index ]]; then
        usage
    fi

    input_fn=${input_file/.noPolyA.noAdapt.fastq.gz/}

    # Aligning to the reference genome:
    bwa aln -n 2 -l 32 -t 8 $genome_index $input_file  > $input_fn.sai
    bwa samse $genome_index -n 1 $input_fn.sai $input_file > $input_fn.sam

    # Converting aligned files from sam to bam format
    samtools view -bh -S $input_fn.sam > $input_fn.unsorted.bam
    samtools sort $input_fn.unsorted.bam $input_fn.sorted
}

main "$@"
