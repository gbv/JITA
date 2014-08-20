#!/usr/bin/env perl
# convert JITA classification to SKOS/RDF
use v5.14;
use pQuery;
use RDF::aREF;
use RDF::NS;
use RDF::Trine;

my $url = 'http://eprints.rclis.org/view/subjects/';
my $base = 'http://example.org/jita/';

# General information, not included in the HTML view
my $jita = {
    $base => {
        a => 'skos:ConceptScheme',
        dct_title => 'JITA Classification System of Library and Information Science@en',
        skos_hasTopConcept => [ map { $base.$_ } 1,2,3 ],
    },
    $base . "1" => {
        a => 'skos:Concept',
        skos_notation  => '1',
        skos_prefLabel => 'Theoretical and General@en',
        skos_narrower => [ map { $base.$_ } 'A'..'B' ],
    },
    $base . "2" => {
        a => 'skos:Concept',
        skos_notation  => '2',
        skos_prefLabel => 'User oriented, directional, and management functionalities@en',
        skos_narrower => [ map { $base.$_ } 'C'..'G' ],
    },
    $base . "3" => {
        a => 'skos:Concept',
        skos_notation  => '3',
        skos_prefLabel => 'Objects, Pragmatics and Technicalities@en',    
        skos_narrower => [ map { $base.$_ } 'H'..'L' ],
    }
};    

my $rdf = $jita;

pQuery($url)->find('a')->each(
    sub {
        my $href  = $_->getAttribute('href');

        return if $_->innerHTML !~ /^([A-Z][A-Z]?)\. (.+)$/;
        my ($notation, $label) = ($1, $2);

        state $broader;

        $jita->{$base.$notation} = {
            a => 'skos:Concept',
            skos_notation => $notation,
            skos_prefLabel => $label.'@en',
        };

        if (length $notation == 1) { # depth 1
            $broader = $base.$notation;
            $jita->{$base.$notation}->{skos_narrower} = [ ];
        } else { # depth 2
            push @{$jita->{$broader}->{skos_narrower}}, $base.$notation;
        }
    }
);

my $model = RDF::Trine::Model->new;
decode_aref( $rdf, callback => $model );

my $ttl = RDF::Trine::Serializer::Turtle->new(
    namespaces => RDF::NS->new,
    base_uri   => $base,
)->serialize_model_to_string($model);

$ttl =~ s/<$base([^>]+)>/<\1>/gm;
print $ttl;

