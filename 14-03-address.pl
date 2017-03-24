#!/usr/bin/perl -w
use strict;

my $bigmatch = 0;               # was anything found?
my $search = '';                # thing to search for

$search = &getpattern();        # prompt for pattern

while () {                      # range over address file
    my %rec = &read_addr();
    if (%rec) {         # got a record
        &perform_search($search, %rec);
    } else {            # end of address file, finish up
        if (!$bigmatch) {
            print "Nothing found.\n";
        } else { print "*********************\n"; }
        last;           # exit, we're done
    }
}

sub getpattern {
    my $in = '';  # input
    print 'Search for what? ';
    chomp($in = <STDIN>);
    return $in;
}

sub read_addr {
    my %curr = ();              # current record
    my $key = '';               # temp key
    my $val = '';               # temp value

    while (<>) {                # stop if we get to EOF
        chomp;
        if (!/^---/) {      # record seperator
            ($key, $val) = split(/: /,$_,2);
            $curr{$key} = $val;
        }
        else { last; }
    }
    return %curr;
}

sub perform_search {
    my ($str, %rec) = @_;
    my $matched = 0;            # overall match
    my $i = 0;                  # position inside pattern
    my $thing = '';             # temporary word

    my @things = $str =~ /("[^"]+"|\S+)/g;  # split into search items

    while ($i <= $#things) {
        $thing = $things[$i];   # search item, AND or OR
        if ($thing =~ /^or$/i) { # OR case
            if (!$matched) {    # no match yet, look at next thing
                $matched = &isitthere($things[$i+1], %rec);
            }
            $i += 2;            # skip OR and next thing
        }
        elsif ($thing =~ /^and$/i) { # AND case
            if ($matched) {     # got a match, need to check other side
                $matched = &isitthere($things[$i+1], %rec);
            }
            $i += 2;            # skip AND and next thing
        }
        elsif (!$matched) {     # no match yet
            $matched = &isitthere($thing, %rec);
            $i++;               # next!
        }
        else { $i++; }          # $match is found, move onto next thing
    }

    if ($matched) {             # all keys done, did we match?
        $bigmatch = 1;          # yes, we found something
        print_addr(%rec);       # print the record then
    }
}

sub isitthere {                 # simple test
    my ($pat, %rec) = @_;
    foreach my $line (values %rec) {
        if ($line =~ /$pat/) {
            return 1;
        }
    }
    return 0;
}

sub print_addr {
    my %record = @_;
    print "*********************\n";
    foreach my $key (qw(Name Phone Fax Address Email URL)) {
        if (defined($record{$key})) {
            print "$record{$key}\n";
        }
    }
}