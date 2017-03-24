#!/usr/ bin/perl -w

package foo;
print "Package foo ...\n";

$bar = 'bar';

package red;
print "Package red ...\n";

$blue = 'blue';

print "Value of \$bar: $bar\n";
print "Value of \$blue: $blue\n";
print "Value of \$foo::bar: $foo::bar\n";