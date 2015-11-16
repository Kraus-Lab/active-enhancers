#!/bin/bash
# intergenic-transcripts.sh

script_name="intergenic-transcripts.sh"
script_ver="1.0.0"

#Help function
usage() {
  echo "Identifying intergenic transcripts:"
  echo ""
  echo "The input files should be sorted before running the bedtools intersect function using the following unix command: sort -k1,1 -k2,2n ip.txt ip_sorted.txt."
  echo "Only reports those entries in transcript file that have no overlap in genic regions to avoid."
  echo ""
  echo ""
  echo "-h Help documentation for $script_name"
  echo "--a  --Transcript universe from groHMM"
  echo "--b  --Genic regions to avoid"
  echo "-v   --Version of script"
  echo "Example: ./$script_name -a transcript_universe_from_groHMM.txt  -b genic_regions_to_avoid.bed"
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
    while getopts :a:b:vh opt
        do
            case $opt in
                a) transcripts=$OPTARG;;
                b) genic_regions=$OPTARG;;
                v) version;;
                h) usage;;
            esac
        done

    shift $(($OPTIND -1))

    # Check for mandatory options
    if [[ -z $transcripts ]] || [[ -z $genic_regions ]]; then
        usage
    fi

    # Identifying intergenic transcripts
    bedtools intersect -a $transcripts -b $genic_regions -v > intergenic_transcripts.txt
}

main "$@"
