#!/usr/local/bin/perl -w

$in = '';      # temporary input
%names = ();   # hash of names
$fn = '';      # temp firstname
$ln = '';      # temp lastname

while () {
    print 'Enter a name (first and last): ';
    chomp($in = <STDIN>);
    if ($in eq '') { last; }

    ($fn, $ln) = split(' ', $in);
    $names{$ln}  = $fn;
}

foreach $lastname (sort keys %names) {
    print "$lastname, $names{$lastname} \n";
}