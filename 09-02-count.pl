#!/usr/bin/perl -w

$pat = ""; # thing to search for
$count = 0; # number of times it occurs

print 'Search for what? ';
chomp($pat = <STDIN>);
while (<>) {
    while (/$pat/g) {
        $count++;
    }
}

print "Found /$pat/ $count times.\n";

# Table 9.3. Pattern Metacharacter Precedence
# 
# Character											Meaning
#========================
# ( )																	grouping and memory
# ? + * { }											quantifiers
# x \x $ ^ (?= ) (?!)	characters, anchors, look-ahead
# |																			alternation