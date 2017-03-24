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