#!/usr/local/bin/perl -w
# numberspeller:  prints out word approximations of numbers
# simple version, only does single-digits

$num = 0;    # raw number
$exit = "";  # whether or not to exit the program.
%numbers = (
    1 => 'one',
    2 => 'two',
    3 => 'three',
    4 => 'four',
    5 => 'five',
    6 => 'six',
    7 => 'seven',
    8 => 'eight',
    9 => 'nine',
    0 => 'zero'
);

while ($exit ne "n") {

    while () {
        print 'Enter the number you want to spell: ';
        chomp($num = <STDIN>);
        if ($num !~ /\d/ or $num =~ /\D/) { # test for strings
            print "No strings.  0 through 9 please.\n";
            next;
        }
        if ($num > 9) { # numbers w/more than 1 digit
            print "Too big. 0 through 9 please.\n";
            next;
        }
        if ($num < 0) { # negative numbers
            print "No negative numbers.  0 through 9 please.\n";
            next;
        }
        last;
    }

    print "Number $num is ";
    print $numbers{$num} ;
    print "\n";

    while () {
        print 'Try another number (y/n)?: ';
        chomp ($exit = <STDIN>);
        $exit = lc $exit;
        if ($exit ne 'y' && $exit ne 'n') {
            print "y or n, please\n";
        }
        else { last; }
    }
}