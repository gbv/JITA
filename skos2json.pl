#!/usr/bin/env perl
use v5.14;
use Catmandu -all;

# convert a classification in SKOS to JSON

my $base = 'http://example.org/jita/';
my $rdf = importer('RDF', file => 'jita-current.ttl')->first;

my $kos = $rdf->{$base};
my $terminology = {
    uri => $base,
    prefLabel => unique_labels(
        $kos->{dct_title}
    ),
    top => [ 
        map { concept($_) } @{$kos->{skos_hasTopConcept}}
    ],
};

exporter('JSON', pretty => 1)->add($terminology);


sub unique_labels {
    my $labels = { };
    foreach (map { @{ $_[0] || [] }} @_) {
        next unless $_ =~ /(.+)@([a-z]+)$/;
        $labels->{$2} = $1;
    }
    return $labels;
}

sub concept {
    my ($uri) = @_;
    $uri =~ s/^<(.+)>$/\1/;

    # ancestors and broader omitted

    my $concept = {
        uri => $uri,
        notation => [substr $uri, length($base)],
        prefLabel => unique_labels( $rdf->{$uri}->{skos_prefLabel} ),
        narrower => [
            map { concept($_) }
            @{ $rdf->{$uri}->{skos_narrower} || [] }
        ]
    };
   
    # TODO: altLabel and note

    return $concept;
}


