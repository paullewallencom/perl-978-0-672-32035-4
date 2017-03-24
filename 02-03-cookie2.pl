#!/usr/local/bin/perl -w

$cookie = "";

while ( $cookie !~ /cookie/i) {
  print 'Give me a cookie: ';
  chomp($cookie = <STDIN>);
}

print "Mmmm.  Cookie.\n";

#	Table 2.5. Operators for Patterns
#	
#	Operator			What it Means
# =========================
#	=~									match test
#	!~									negated match test
#	m/…/ /…/			pattern
#	m/…/i /…/i	case insensitive pattern