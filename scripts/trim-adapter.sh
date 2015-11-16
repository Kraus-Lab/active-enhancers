#!/bin/bash
# trim-adapter.sh

script_name="trim-adapter.sh"
script_ver="1.0.0"

#Help function
usage() {
  echo "Trimming adapter sequence:"
  echo ""
  echo "The adapter sequence should be trimmed from the GRO-seq reads to increase the fraction of reads that can be aligned to the reference genome."
  echo "Only reads which are > 32 bp in length after adapter trimming are retained for further analysis."
  echo "A default maximum error rate of 0.1 is used."
  echo "The statistics regarding the reads that are trimmed in this step are written to an output statistics file ‘<input_file_name>.trim-adapter.out’"
  echo ""
  echo ""
  echo "-h Help documentation for $script_name"
  echo "-f  --Fastq file"
  echo "-a  --Adapter sequence"
  echo "-v  --Version of script"
  echo "Example: ./$script_name -a TCGTATCCCGTCTTCTGCTTG  -f inputfile.fastq.gz"
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
    while getopts :f:a:vh opt
        do
            case $opt in
                f) input_file=$OPTARG;;
                a) adapter=$OPTARG;;
                v) version;;
                h) usage;;
            esac
        done

    shift $(($OPTIND -1))

    # Check for mandatory options
    if [[ -z $input_file ]] || [[ -z $adapter ]]; then
        usage
    fi

    input_fn=${input_file/.fastq.gz/}

    # Trimming adapter sequence
    cutadapt -a adapter -z -e 0.10 --minimum-length=32 --output=$input_fn.noAdapt.fastq.gz $input_file 2>&1 >> $input_fn.trim-adapter.out
}

main "$@"
