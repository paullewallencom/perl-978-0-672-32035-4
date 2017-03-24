#!/usr/ bin/perl -w

$global = " global available here\n";

&subA();
print "Main script:\n";
foreach $var ($global, $mylocal, $locallocal) {
    if (defined $var) {
        print $var;
    }
}

sub subA {
    my $mylocal = " mylocal available here\n";
    local $locallocal = " local local available here\n";
    print "SubA:\n";
    foreach $var ($global, $mylocal, $locallocal) {
        if (defined $var) {
            print $var;
        }
    }
    &subB();
}

sub subB {
    print "SubB: \n";
    foreach $var ($global, $mylocal, $locallocal) {
        if (defined $var) {
            print $var;
        }
    }
}