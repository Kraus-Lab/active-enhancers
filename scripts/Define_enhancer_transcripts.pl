#!/usr/bin/perl
use strict;
use Getopt::Std;

my $infile;
my $outfile1;
my $outfile2;
my $outfile3;
my $help;
my %Options;
my $optset=getopts('i:a:b:c:h:',\%Options);
my $size = keys %Options;

if($size == 0 || !$optset || $Options{h})
{
	print "Usage: ./Define_enhancer_transcripts.pl  -i <Infile> -a <OutputFile1> -b <OutputFile2> -c <OutputFile3> \n";
	print "Options:\n";
	print "        -i Input transcripts\n";
	print "        -a Intergenic Short transcripts\n";
	print "        -b Length of Overlaps\n";
	print "        -c 1kb window around center of overlap of intergenic short paired\n";
	die("Get ready with the files… \n");
}

# Declaring the variables
my $infile=$Options{i};
my $outfile1=$Options{a};
my $outfile2=$Options{b};
my $outfile3=$Options{c};
my $length=0;
my @coord=();

# Read the input file with intergenic transcripts
open (FILE1, "<$infile") || die "can't: $!";

# Output file1 with short intergenic transcripts
open(OUTPUT1, ">$outfile1") or die("Unable to open file");

while(<FILE1>)
{
my $line1 = $_;
chomp($line1);
@coord=split(/\t/,"$line1");

# Calculating transcript lengths
$length = $coord[2]-$coord[1];

# Selecting the transcripts shorter than 9 kb
if($length < 9000)
{
	print OUTPUT1 "$line1\n";
}
}

# Sorting the short intergenic transcripts based on the chromosome, start position
$a=`sort -k1,1 -k2n,2 $outfile1 >sort_$outfile1`;

# Identifying intergenic short paired transcripts
open (FILE, "<sort_$outfile1") || die "can't: $!";

# Output file2 with a list of short paired transcripts, length of the overlap
open(OUTPUT2, ">$outfile2") or die("Unable to open file");

# Output file3 with the coordinates of a 1kb window around the center of the overlap of intergenic short paired transcripts
open(OUTPUT3, ">$outfile3") or die("Unable to open file");

# Declaring the variables to be used
my @line=<FILE>;
my @firstline=();
my @secondline=();
my $j;
my $overlap;
my $overlap_center;
my $window_start;
my $window_end;

# Read the lines of the file and store in an array; accessing each line through for loop
for(my $i=1;$i<=$#line;$i++)
{
# Comparing two consecutive lines to check overlap
	$j=$i+1;
	@firstline=split(/\t/,"$line[$i]");
	@secondline=split(/\t/,"$line[$j]");

# Matching the chromosome number of the two consecutive lines and checking if overlap exists to define the universe of paired transcripts
	if($firstline[0] eq $secondline[0] && $firstline[1] <= $secondline[2] && $firstline[2] >= $secondline[1])
	{
		# Calculating overlap, overlap center
		$overlap=$firstline[2]-$secondline[1];
		$overlap_center = int(($firstline[2]+$secondline[1])/2);

# Calculating a 500 bp window on either side of the overlap center
		$window_start = $overlap_center-500;
		$window_end = $overlap_center+500;

# Writing a list of short paired transcripts, length of the overlap to output1
		print OUTPUT2 "$line[$i]$line[$j]\t\t\t\t\t\t\t\t\t\t$overlap\n";

# Writing the coordinates of a 1 kb window around the length of the overlap to output2
		print OUTPUT3 "$firstline[0]\t$window_start\t$window_end\t$overlap_center\n";
	}
}
