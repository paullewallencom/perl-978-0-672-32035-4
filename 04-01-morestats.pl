#!/usr/local/bin/perl -w

$input = '';  # temporary input
@nums = ();   # array of numbers;
$count = 0;   # count of numbers
$sum = 0;     # sum of numbers
$avg = 0;     # average
$med = 0;     # median

while () {
  print 'Enter a number: ';
  chomp ($input = <STDIN>);
  if ($input eq '') { last; }

  if ($input =~ /\D/) {
      print "Digits only, please.\n";
      next;
  }

  push @nums, $input;
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
print "Median: $med\n";