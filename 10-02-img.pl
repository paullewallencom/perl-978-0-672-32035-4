#!/usr/local/bin/perl -w

$/ = "";     # paragraph input mode
$raw = "";   # raw attributes
%atts = ();  # attributes

while (<>) {
    while (/<img\s(.+?)>/igs ) {
        $raw = $1;
        while ($raw =~ /(\w+)\s*=\s*(("|')(.*?)\3|(\w*)\s*)/igs) {
           if (defined $4) {
              $atts{ lc($1) }  = $4;
           }  else { $atts{ lc($1)}  = $2; }
        }
        if ($raw =~ /ismap/i) {
            $atts{'ismap'} = "Yes";
        }

        print '-' x 15;
        print "\nImage:  $atts{'src'} \n";
        foreach $key ("width", "height",
                      "border", "vspace", "hspace",
                      "align", "alt", "lowsrc", "ismap") {
             if (exists($atts{$key} )) {
                $atts{$key}  =~ s/\s*\n/ /g;
                print "   $key: $atts{$key} \n";
             }
        }
        %atts = ();
    }
}

# Table 10.1. Pattern Matching and Substitution Options
# 
# Option	Use
#=================
# g						Match all occurrences (not just one)
# i						Match both upper and lowercase
# m						Use ^ and $ for newlines
# o						Interpolate pattern once (for better efficiency)
# s						Dot (.) includes newlines
# x						Extend regular expressions (can include comments and whitespace)
# e						Evaluate replacement as a Perl expression (s/// substitution only)

# Table 10.2. Pattern Matching Escapes
# 
# Escape	Use
#==================
# \A					Beginning of string
# \Z					End of string
# \w					Word character
# \W					Non-word character
# \b					Word boundary
# \B					Non-word boundary
# \s					Whitespace character
# \S					Non-whitespace character
# \d					Digit
# \D					Non-digit
# \Q					Escape all special characters
# \E					End \Q sequence