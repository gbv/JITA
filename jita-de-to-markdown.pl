#!/usr/bin/env perl
# Convert German JITA classification to Markdown list with links to ELIS & IFLA
use v5.14;

my ($elis_png, $ifla_png) = ("ELIS.png", "IFLA.png");

while(<>) {    
    next if $_ !~ /^(\s*)([0-9]|[A-Z]{1,2})\.\s+(.+)/;
    my ($level,$notation, $label) = ($1, $2, $3);
    $label =~ s/\s+$//;

    my $img = "";
    my $url;
    if ($notation =~ /^[A-Z]+$/) {
        my $n = length $notation == 1 ? $notation."=2E" : $notation;
        $img = " -- [![]($elis_png)](http://eprints.rclis.org/view/subjects/$n.html)"
             . " [![]($ifla_png)](http://library.ifla.org/view/subjects/$notation.html)";
    } 

    say "$level* **$notation.** $label $img";
}
