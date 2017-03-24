#!/usr/local/bin/perl -w

$price = 0;  # stock price
$whole  = 0; # temp whole number
$frac = "";  # temp fractional num
$numer = 0;  # numerator
$denom = 0;  # denominator

while () {
    print "Enter a stock price: ";
    chomp ($price  = <STDIN>);
    if ($price eq '') { last; }

    if ($price =~ /\//) {  # process fractions
        if ($price =~ /\d\s+/) { # "14 5/8" (numbers with whole part)
            ($whole, $frac) = split(' ', $price);
        }  else { # "5/8" (no whole part)
            $whole = 0;
            $frac = $price;
        }

        ($numer, $denom) = split(/\//,$frac);
        $price = $whole + ($numer / $denom);
        $price = sprintf("%.2f", $price);
    }
  
    if ($price =~ /\D/ and $price !~ /\./ ) {
        print "Digits only, please.\n";
        next;
    }

    print "Price: $price\n";
}

# Table 5.1. Patterns
# 
# Pattern	Type																									What it does
#======================
# /a/					Character																				Matches a
# /\d/				Any digit																				Matches a single digit
# /\D/				Any character not a digit				Matches a single character other than a digit
# /\s/				Any whitespace															Matches a single space, 
#																																						tab, newline, carriage return or formfeed
# /\S/				Any character not whitespace	Matches a single character other than whitespace
# +							One or more																		Matches one or more of the pattern just before it