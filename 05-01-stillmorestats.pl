#!/usr/local/bin/perl -w

$input = '';  # temporary input
@nums = ();   # array of numbers;
%freq = ();   # hash of number frequencies
$count = 0;   # count of numbers
$sum = 0;     # sum of numbers
$avg = 0;     # average
$med = 0;     # median
$maxspace = 0;# max space for histogram

while () {
  print 'Enter a number: ';
  chomp ($input = <STDIN>);
  if ($input eq '') { last; }

  if ($input =~ /\D/) {
      print "Digits only, please.\n";
      next;
  }

  push @nums, $input;
  $freq{$input} ++;
  $count++;
  $sum += $input;
}

@nums = sort { $a <=> $b }  @nums;
$avg = $sum / $count;
$med = $nums[$count / 2];

print "\nTotal count of numbers: $count\n";
print "Total sum of numbers: $sum\n";
print "Minimum number: $nums[0]\n";
print "Maximum number: $nums[$#nums]\n";
printf("Average (mean): %.2f\n", $avg);
print "Median: $med\n\n";
print "Frequency of Values:\n";

$maxspace = (length $nums[$#nums]) + 1;

foreach $key (sort { $a <=> $b }  keys %freq) {
  print $key;
  print ' ' x ($maxspace - length $key);
  print '| ', '*' x $freq{$key} , "\n";
}

ble 4.1. Output Global Variables

riable Name			What it does
===========================
														Output field separator; 
														the characters to print in 
														between list elements. 
														Empty by default.
														Output record separator; 
														the characters to print at the 
														end of a list. 
														Empty by default.
														Same as the output field separator, 
														except only for list variables 
														interpolated inside strings. 
														A single space by default.