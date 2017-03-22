#!/usr/local/bin/perl -w
#
# Cookie Monster

$cookie = "";

while( $cookie ne 'cookie' ){
	print 'Give me a cookie: ';
	chomp( $cookie = <STDIN> );
}

print "Mmmm. Cookie.\n";