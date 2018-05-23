#!/usr/bin/perl

my $usage = "GRM_tensorflow.pl GRM_file output_base\n";

unless ($#ARGV == 1) {
    die $usage;
}

open (READ, $ARGV[0]);
open (W1, ">$ARGV[1]\.tab.txt");
open (W2, ">$ARGV[1]\.id.txt");

my $header = <READ>;
chomp($header);
$header =~ s/^([^,]+),.+/\1/;
my @IDs;
while (<READ>) {
   s/,/\t/g;
   s/^([^\s]+)\t//;
   push (@IDs, $1);
   print W1 $_;
}
close READ;
close W1;

print W2 "\#", $header, "\t", $header, "\n";
foreach my $n (@IDs) {
    print W2 $n, "\t", $n, "\n";
}
close W2;
 
