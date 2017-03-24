#!/usr/ bin/perl -w
use strict;

my @nums = (); # array of numbers;
my $choice = "";

# main script
&getinput();
while ($choice !~ /q/i) {
    $choice = &printmenu();
  SWITCH: {
      $choice =~ /^1/ && do { &printdata(); last SWITCH; };
      $choice =~ /^2/ && do { &countsum(); last SWITCH; };
      $choice =~ /^3/ && do { &maxmin(); last SWITCH; };
      $choice =~ /^4/ && do { &meanmed(); last SWITCH; };
      $choice =~ /^5/ && do { &printhist(); last SWITCH; };
  }
}

# read in the input from the files, sort it once its done
sub getinput {
    while (<>) {
        chomp;
        next if (/\D/);
        push @nums, $_;
    }
    @nums = sort { $a <=> $b } @nums;
}
# our happy menu to be repeated until Q
sub printmenu {
    my $in = "";
    print "Please choose one (or Q to quit): \n";
    print "1. Print data set\n";
    print "2. Print count and sum of numbers\n";
    print "3. Print maximum and minimum numbers\n";
    print "4. Print mean and median numbers\n";
    print "5. Print a histogram of the frequencies.\n";
    while () {
        print "\nYour choice --> ";
        chomp($in = <STDIN>);
        if ($in =~ /^\d$/ || $in =~ /^q$/i) {
            return $in;
        } else {
            print "Not a choice.  1-5 or Q, please,\n";
        }
    }
}
# print out the data set, ten numbers per line
sub printdata {
    my $i = 1;
    print "Data Set: \n";
    foreach my $num (@nums) {
        print "$num ";
        if ($i == 10) {
            print "\n";
            $i = 1;
        } else { $i++; }
    }
    print "\n\n";
}

# print the number of elements and the sum
sub countsum {
    print "Number of elements: ", scalar(@nums), "\n";
    print "Sum of elements: ", &sumnums(), "\n\n";
}

# find the sum
sub sumnums {
    my $sum = 0;
    foreach my $num  (@nums) {
        $sum += $num;
    }
    return $sum;
}

# print the max and minimum values
sub maxmin {
    print "Maximum number: $nums[0]\n";
    print "Minimum number: $nums[$#nums]\n\n";
}

# print the mean and median
sub meanmed {
    printf("Average (mean): %.2f\n", &sumnums() / scalar(@nums));
    print "Median: $nums[@nums / 2]\n\n";
}

# print the histogram.  Build hash of frequencies & prints.
sub printhist {
    my %freq = ();
    my $maxfreq = 0;
    my @keys = ();
    my $space = 0;
    my $totalspace = 0;
    my $num;
    # build frequency hash, set maxfreq
    foreach $num (@nums) {
        $freq{$num} ++;
        if ($maxfreq < $freq{$num} ) { $maxfreq = $freq{$num} }
    }

    # print hash
    @keys = sort { $a <=> $b } keys %freq;
    for (my $i = $maxfreq; $i > 0; $i--) {
        foreach $num (@keys) {
            $space = (length $num);
            if ($freq{$num} >= $i) {
                print( (" " x $space) . "*");
            } else {
                print " " x (($space) + 1);
            }
            if ($i == $maxfreq) { $totalspace += $space + 1; }
        }
        print "\n";
    }
    print "-" x $totalspace;
    print "\n @keys\n\n";
}