#!/usr/ bin/perl -w

$top = 0;  # topmost number
$num = 0;  # random number
$count = 0; # number of guesses
$guess = ""; # actual guess
$done = "";  # done guessing?

while () {
    print 'Enter top number: ';
    chomp($top = <STDIN>);

    if ($top =~ /\D/) {  # non-numbers, also negative numbers
        if ($top =~ /-\d+/) { # only negative numbers
            print "Positive numbers only\n";
        } else {
            print "Digits only.\n";
        }
        next;
    } elsif ($top <= 1 ) {
        print "Numbers greater than 1 only.\n";
        next;
    }

    last;
}

srand;
$num = int(rand $top) + 1;

while (!$done) {
    print "Pick a number between 1 and $top: ";
    chomp($guess = <STDIN>);

    if ($guess =~ /\D/) {
        if ($guess =~ /-\d+/) {
            print "Positive numbers only\n";
        } else {
            print "Digits only.\n";
        }
        next;
    } elsif ($guess == 0) {
        print "Numbers greater than 0 only.\n";
    } elsif ($guess < $num) {
        print "Too low!\n";
        $count++;
    } elsif ($guess > $num) {
        print "Too high!\n";
        $count++;
    } else {
        print "\a\aCorrect!  \n";
        $count++;
        $done = 1;
    }
}
print "Congratulations!  It took you $count guesses";
print " to pick the right number.\n";