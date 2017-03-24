#!/usr/local/bin/perl

print "Enter a value and this program will try to guess what type of\n";
print "value it is. Enter 'q' by itself on a line to quit.\n";

while () {
    print "Enter a value: ";
    chomp($value = <STDIN>);

    if ($value =~ /^$/) {
        print "Please enter a value.\n";
        next;
    }

    last if ($value =~ /^q$/i);

    if ($value =~/^(male|female)$/i) {
        print "$value looks like a gender.\n";
        next;
    }

    if ($value =~ /^\d+\s[A-Z][\w\s]*$/) {
        print "$value looks like a street address.\n";
        next;
    }

    if ($value =~ /^[\w.]+@\w[\w.-]+\w\.[A-Za-z]{2,4} $/) {
        print "$value looks like an email address.\n";
        next;
    }

    if ($value =~ /^[A-Z][a-z]+,\s[A-Z]{2} \s{1,2} \d{5} $/) {
        print "$value looks like a city, state, and zip code.\n";
        next;
    }

    if ($value =~ /^\W{0,1} \d{3} \W{0,1} \s{0,1}
                    \W{0,1} \s{0,1} \d{3} \s{0,1} \W{0,1} \s{0,1} \d{4} $/x) {
        print "$value looks like a telephone number.\n";
        next;
    }

    if ($value =~ /^perl$/i) {
        print "$value looks like the name of a programming language.\n";
        next;
    }

    print "I couldn't figure out what that value is.\n";
}

# Table 9.1. Boundaries
# 
# Boundary Character		Matches
#=======================
# ^																			The beginning of a string or line
# $																			The end of a string or line
# \b																		A word boundary
# \B																		Anything other than a word boundary

#Table 9.2. Character Class Codes
#
#Code	Equivalent Character Class	What It Means
#==========================
#\d			[0-9]																						Any digit
#\D			[^0-9]																					Any character not a digit
#\w			[0-9a-zA-z_]															Any “word character”
#\W			[^0-9a-zA-z_]														Any character not a word character
#\s			[ \t\n\r\f]																whitespace (space, tab, newline, 
#																																carriage return, form feed)
#\S			[^ \t\n\r\f]															Any nonwhitespace character