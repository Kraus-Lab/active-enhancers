#!/bin/bash
# quality-metric-fastqc.sh

script_name="quality-metric-fastqc.sh"
script_ver="1.0.0"

# Help function
usage() {
  echo "Quality control:"
  echo ""
  echo "Check qaulity of fastq's and for contamination from the sequencing adapters or the polyA addition."
  echo ""
  echo ""
  echo "-h Help documentation for $script_name"
  echo "-f  --Fastq file"
  echo "-v  --Version of script"
  echo "Example: ./$script_name -f inputfile.fastq.gz"
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
    while getopts :fvh opt
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

    # Quality control:
    fastqc $input_file

}

main "$@"
