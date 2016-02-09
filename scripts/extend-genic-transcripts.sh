#!/bin/bash
# extend-genic-transcripts.sh

script_name="extend-genic-transcripts.sh"
script_ver="1.0.0"

#Help function
usage() {
  echo "Extending genic transcripts:"
  echo ""
  echo "Extend 10 kb away from either end of annotated genes in order to distinguish enhancer transcription from genic transcription."
  echo ""
  echo ""
  echo "-h   Help documentation for $script_name"
  echo "--f  --Annotation file (BED format)"
  echo "--g  --Chromosome length file"
  echo "-v   --Version of script"
  echo "Example: ./$script_name -f annotated_genes.bed  -g chromosome_info.txt"
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
    while getopts :f:g:vh opt
        do
            case $opt in
                f) annotations=$OPTARG;;
                g) chrom_info=$OPTARG;;
                v) version;;
                h) usage;;
            esac
        done

    shift $(($OPTIND -1))

    # Check for mandatory options
    if [[ -z $annotations ]] || [[ -z $chrom_info ]]; then
        usage
    fi

    input_fn=${annotations/.bed/}

    # Extending genic transcripts
    bedtools slop -i $annotations -g $chrom_info -b 10000 > $input_fn\_10kb_flanking.bed
}

main "$@"
