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
       $line{'site'} = $1;
       $line{'date'} = $3;
       $line{'file'} = $5;
       $line{'code'} = $7;
       return %line;
    } else { return (); }
}