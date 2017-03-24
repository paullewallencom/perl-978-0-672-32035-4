sub read_addr {
    my %curr = ();              # current record
    my $key = '';               # temp key
    my $val = '';               # temp value

    while (<>) {                # stop if we get to EOF
        chomp;
        if (!/^---/) {      # record seperator
            ($key, $val) = split(/: /,$_,2);
            $curr{$key} = $val;
        }
        else { last; }
    }
    return %curr;

}