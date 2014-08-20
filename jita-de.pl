#!/usr/bin/env perl
# convert JITA classification to SKOS/RDF
use v5.14;

say '@prefix skos: <http://www.w3.org/2004/02/skos/core#> .';
say '@base <http://example.org/jita/> .';

my $base = 'http://example.org/jita/';
while(<>) {    
    next if $_ !~ /^\s*([0-9A-Z]+)\.\s+(.+)/;
    my ($notation, $label) = ($1, $2);
    $label =~ s/\s+$//;
    say "<$notation> skos:prefLabel \"$label\"\@de .";
}
