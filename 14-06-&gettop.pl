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