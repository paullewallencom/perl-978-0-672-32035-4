#!/usr/local/bin/perl -w

$input = ''; # temporary input
$count = 0;  # count of numbers
$sum = 0;    # sum of numbers
$avg = 0;    # average

while () {
 print 'Enter a number: ';
	chomp ($input = <STDIN>);
	if ($input eq '') { last; }

	if ($input =~ /\D/) {
 	print "Digits only, please.\n";
  next;
	}

	$count++;
	$sum += $input;
}

$avg = $sum / $count;

print "\nTotal count of numbers: $count\n";
print "Total sum of numbers: $sum\n";
printf("Average (mean): %.2f\n", $avg);

# Table 3.3. Patterns
# 
# Pattern		Type																									What it does
# /a/						Character																				Matches a
# /\d/					Any digit																				Matches a single digit
# /\D/					Any character not a digit				Matches a single character other than a digit