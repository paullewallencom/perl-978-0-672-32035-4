#!/usr/local/bin/perl -w
#
# webbuild:  simple text-file conversion to HTML
# *very* simple.  Assumes no funky characters, embedded
# links or boldface, etc.  Blank spaces == paragraph
# breaks.

$title = '';                    # <TITLE>
$bgcolor = '';                  # BGCOLOR
$text = '';                     # TEXT
$head = '';                     # main heading
$mail = '';                     # email address
$paragraph = '';                # is there currently an open paragraph tag?

print "Enter the title to use for your web page: ";
chomp($title = <STDIN>);

foreach $color ('background', 'text') { # run twice, once for each color
    $in = '';                   # temporary input
    while () {
        print "Enter the $color color (? for options): ";
        chomp($in = <STDIN>);
        $in = lc $in;

        if ($in eq '?') {       # print help
            print "One of: \nwhite, black, red, green, blue,\n";
            print "orange, purple, yellow, aqua, gray,\n";
            print "silver, fuchsia, lime, maroon, navy,\n";
            print "olive, or Return for none\n";
            next;
        }  elsif ($in eq '' or
                 $in eq 'white' or
                 $in eq 'black' or
                 $in eq 'red' or
                 $in eq 'blue' or
                 $in eq 'green' or
                 $in eq 'orange' or
                 $in eq 'purple' or
                 $in eq 'yellow' or
                 $in eq 'aqua' or
                 $in eq 'gray' or
                 $in eq 'silver' or
                 $in eq 'fuchsia' or
                 $in eq 'lime' or
                 $in eq 'maroon' or
                 $in eq 'navy' or
                 $in eq 'olive') { last; }
        else {
            print "that's not a color.\n";
        }
    }

    if ($color eq 'background') {
        $bgcolor = $in;
    }  else {
        $text = $in;
    }
}

print "Enter a heading: ";
chomp($head = <STDIN>);

print "Enter your email address: ";
chomp($mail = <STDIN>);

print '*' x 30;

print "\n<html>\n<head>\n<title>$title</title>\n";
print "</head>\n<body";
if ($bgcolor ne '') { print qq( bgcolor="$bgcolor"); }
if ($text ne '') { print qq( text="$text"); }
print">\n";
print "<h1>$head</h1>\n<p>";
$paragraph = 'y';

while (<>) {
    if ($_ =~ /^\s$/) {
        if ($paragraph eq 'y') {
            print "</p>\n";
            $paragraph = 'n';
        }

        print "<p>\n";
        $paragraph = 'y';
    }  else {
        print $_;
    }
}

if ($paragraph eq 'y') {
    print "</p>\n";
}

print qq(<hr>\n<address><a href="mailto:$mail">$mail</a></address>\n);
print "</body>\n</html>\n";