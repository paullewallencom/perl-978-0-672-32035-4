#!/usr/bin/perl

while (<>)
{
    while (/<(\w+)(.*?)>/g)
    {
        print "Tag: $1\n";

        my $attrs = $2;

        while ($attrs =~ /(\w+)=('|")(.+?)\2/g)
        {
            print "Attribute: $1\n";
            print "Value: $3\n";
        }
    }
}