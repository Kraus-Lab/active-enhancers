#!/bin/bash
# trim-polyA.sh

script_name="trim-polyA.sh"
script_ver="1.0.0"

#Help function
usage() {
  echo "Trimming polyA tail:"
  echo ""
  echo "The polyA tail should be trimmed from the GRO-seq reads to increase the fraction of reads that can be aligned to the reference genome."
  echo "Only reads which are > 32 bp in length after adapter trimming are retained for further analysis."
  echo "A default maximum error rate of 0.1 is used."
  echo "The statistics regarding the reads that are trimmed in this step are written to an output statistics file ‘<input_file_name>.trim-polyA.out’"
  echo ""
  echo ""
  echo "-h Help documentation for $script_name"
  echo "-f  --Fastq file"
  echo "-v  --Version of script"
  echo "Example: ./$script_name -f filename.noAdapt.fastq.gz"
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
    while getopts :f:vh opt
        do
            case $opt in
                f) input_file=$OPTARG;;
                v) version;;
                h) usage;;
            esac
        done

    shift $(($OPTIND -1))

    # Check for mandatory options
    if [[ -z $input_file ]]; then
        usage
    fi

    input_fn=${input_file/.fastq.gz/}

    # Trimming polyA tail
    cutadapt -a AAAAAAAAAAAAAAAAAAAA -z -e 0.10 --minimum-length=32 --output=$input_file.noPolyA.noAdapt.fastq.gz $input_file 2>&1 >> $input_fn.trim-polyA.out
}

main "$@"
