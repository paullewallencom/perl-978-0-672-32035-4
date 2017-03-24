sub perform_search {
    my ($str, %rec) = @_;
    my $matched = 0;            # overall match
    my $i = 0;                  # position inside pattern
    my $thing = '';             # temporary word

    my @things = $str =~ /("[^"]+"|\S+)/g;  # split into search items

    while ($i <= $#things) {
        $thing = $things[$i];   # search item, AND or OR
        if ($thing =~ /^or$/i) { # OR case
            if (!$matched) {    # no match yet, look at next thing
                $matched = &isitthere($things[$i+1], %rec);
            }
            $i += 2;            # skip OR and next thing
        }
        elsif ($thing =~ /^and$/i) { # AND case
            if ($matched) {     # got a match, need to check other side
                $matched = &isitthere($things[$i+1], %rec);
            }
            $i += 2;            # skip AND and next thing
        }
        elsif (!$matched) {     # no match yet
            $matched = &isitthere($thing, %rec);
            $i++;               # next!
        }
        else { $i++; }         # $match is found, move onto next thing
    }

    if ($matched) {             # all keys done, did we match?
        $bigmatch = 1;  # yes, we found something
        print_addr(%rec);      # print the record then
    }
}