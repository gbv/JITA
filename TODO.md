* Fix RDF/SKOS representation of JITA
    * Use skos:notation instead of putting notations in the prefLabel
    * Add skos:hasTopConcept / skos:topConceptOf for top classes
        * <http://aims.fao.org/aos/jita/T>
        * <http://aims.fao.org/aos/jita/P>
        * <http://aims.fao.org/aos/jita/O>
    * Change JITA URI 
        * from <http://aims.fao.org/aos/jita/void.rdf#JITA> 
        * to <http://aims.fao.org/aos/jita/>
* Add German translations
* Convert Concept Scheme to JSON
* Extract mappings and convert to JSON and/or BEACON
