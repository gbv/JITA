* Fix RDF/SKOS representation of JITA
    * Add skos:notation as given at E-LIS and IFLA repository
    * Remove putting notations from prefLabel
    * Add skos:hasTopConcept / skos:topConceptOf for top classes
        * <http://aims.fao.org/aos/jita/T>
        * <http://aims.fao.org/aos/jita/P>
        * <http://aims.fao.org/aos/jita/O>
    * Change JITA URI 
        * from <http://aims.fao.org/aos/jita/void.rdf#JITA> 
        * to <http://aims.fao.org/aos/jita/>
    * Change JITA concept URIs
        * use notations instead of inofficial mnemonics

* Add German translations
* Convert Concept Scheme to JSON
* Extract mappings and convert to JSON and/or BEACON
