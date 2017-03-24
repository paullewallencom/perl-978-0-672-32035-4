#!/usr/ bin/perl -w
use strict;

use Text::Wrap;                 # import module
my $indent ="> ";              # indent character

while (<>) {
    print wrap($indent, $indent, $_);
}