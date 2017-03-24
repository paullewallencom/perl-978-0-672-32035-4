#!/usr/bin/perl -w
use strict;

my $default = 'index.html';     # change to be your default HTML file
my $topthings = 30;             # number of files, sites, etc to report
my $totalhits = 0;
my $failhits = 0;
my $htmlhits = 0;
my %hosts= ();
my %files = ();

&process_log();
&print_results();

sub process_log {
    my %hit = ();
    my $currdate = '';
    my $dateshort = '';
    print "Processing log....\n";
    while (<>) {
        chomp;
        %hit = splitline($_);
        $totalhits++;

        # watch out for malformed lines
        if (!%hit) {  # malformed line in web log
            $failhits++;
            next;
        }

        $dateshort = &getday($hit{'date'});
        if ($currdate ne $dateshort) {
            print "Processing $dateshort\n";
            $currdate = $dateshort;
        }

        # watch 404s
        if ($hit{'code'} =~ /^4/) { # 404, 403, etc. (errors)
            $failhits++;
        # other files
        } elsif ($hit{'code'} =~ /200|304/) {   # deal only with sucesses
            if ($hit{'file'} =~ /\/$/) { # slashes map to $default
                $hit{'file'} .= $default;
            }

            if ($hit{'file'} =~ /\.html?$/) { # .htm or .html
                $htmlhits++;
            }

            $hosts{ $hit{'site'} }++;
            $files{ $hit{'file'} }++;
        }
    }
}

sub splitline {
    my $in = $_[0];
    my %line = ();
    if ($in =~ /^([^\s]+)\s           # site
               ([\w-]+\s[\w-]+)\s     # users
               \[([^\]]+)\]\s         # date
                \"(\w+)\s             # protocol
               (\/[^\s]*)\s           # file
               ([^"]+)\"\s            # HTTP version
               (\d{3})\s              # return code
               ([\d-]+)               # bytes transferred
         /x) {
       # we only care about some of the values
       # (every other one, coincidentally)
       $line{'site'} = $1;
       $line{'date'} = $3;
       $line{'file'} = $5;
       $line{'code'} = $7;
       return %line;
    } else { return (); }
}

sub getday {
    my $date;
    if ($_[0] =~ /([^:]+):/) {
        $date = $1;
        return $date;
    } else {
        return $_[0];
    }
}

sub print_results {
    if ($totalhits == 0) {
        print "The log file is empty.\n";
        exit;
    }

    print "Web log file Results:\n";
    print "Total Number of Hits: $totalhits\n";
    print "Total failed hits: $failhits (";
    printf('%.2f', $failhits / $totalhits * 100);
    print "%)\n";

    print "(sucessful) HTML files: $htmlhits (";
    printf('%.2f', $htmlhits / ($totalhits - $failhits) * 100);
    print "%)\n";

    print 'Number of unique hosts: ';
    print scalar(keys %hosts);
    print "\n";

    my %domains = &getdomains(keys %hosts);
    print 'Number of unique domains: ';
    print scalar(keys %domains);
    print "\n";

    print "Most popular files: \n";
    foreach my $file (&gettop(%files)) {
       print "  $file\n";
    }
    print "Most popular hosts: \n";
    foreach my $host (&gettop(%hosts)) {
       print "  $host\n";
    }

    print "Most popular domains: \n";
    foreach my $dom (&gettop(%domains)) {
       print "  $dom\n";
    }
}

sub getdomains {
    my %domains = ();
    my ($sd,$d,$tld);       # secondary domain, domain, top-level domain
    foreach my $host (@_) {
        my $dom = '';
        if($host =~ /(([^.]+)\.)?([^.]+)\.([^.]+)$/ ) {
            if (!defined($1)) { # only two domains (i.e. aol.com)
                ($d,$tld) = ($3, $4);
            } else {            # a usual domain x.y.com etc
                ($sd, $d, $tld) = ($2, $3, $4);
            }
            if ($tld =~ /\D+/) { # ignore raw IPs
                if ($tld =~ /com|edu|net|gov|mil|org$/i) { # US TLDs
                    $dom = "$d.$tld";
                } else { $dom = "$sd.$d.$tld"; }
                $domains{$dom} += $hosts{$host};
            }
        } else { print "Malformed: $host\n"; }
    }
    return %domains;
}

sub gettop {
    my %hash = @_;
    my $i = 1;
    my @topkeys = ();
    foreach my $key (sort { $hash{$b} <=> $hash{$a} } keys %hash) {
        if ($i <= $topthings) {
            push @topkeys, "$key ($hash{$key} hits)";
            $i++;
        }
    }
    return @topkeys;
}