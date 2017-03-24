#!/usr/loczl/bin/perl -w

$input = "";  # temporary input
@nums = ();   # array of numbers;
%freq = ();   # hash of number frequencies
$maxfreq = 0; # maximum frequency
$count = 0;   # count of numbers
$sum = 0;     # sum of numbers
$avg = 0;     # average
$med = 0;     # median
@keys = ();   # temp keys
$totalspace = 0; # total space across histogram

while (defined ($input = <>)) {
    chomp ($input);
    $nums[$count] = $input;
    $freq{$input} ++;
    if ($maxfreq < $freq{$input} ) { $maxfreq = $freq{$input}  }
    $count++;
    $sum += $input;
}
@nums = sort { $a <=> $b }  @nums;

$avg = $sum / $count;
$med = $nums[$count /2];

print "\nTotal count of numbers: $count\n";
print "Total sum of numbers: $sum\n";
print "Minimum number: $nums[0]\n";
print "Maximum number: $nums[$#nums]\n";
printf("Average (mean): %.2f\n", $avg);
print "Median: $med\n\n";

@keys = sort { $a <=> $b }  keys %freq;

for ($i = $maxfreq; $i > 0; $i--) {
    foreach $num (@keys) {
        $space = (length $num);
        if ($freq{$num}  >= $i) {
            print( (" " x $space) . "*");
        } else {
            print " " x (($space) + 1);
        }
        if ($i == $maxfreq) { $totalspace += $space + 1; }
    }
    print "\n";
}
print "-" x $totalspace;
print "\n @keys\n";