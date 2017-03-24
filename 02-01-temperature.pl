#!/usr/local/bin/perl -w

$fahr = 0;
$cel = 0;

print 'Enter a temperature in Fahrenheit: ';
chomp ($fahr = <STDIN>);
$cel = ($fahr - 32) * 5 / 9;
print "$fahr degrees Fahrenheit is equivalent to ";
printf("%.0f degrees Celsius\n", $cel);