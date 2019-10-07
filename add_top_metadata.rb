require './utils.rb'
require 'rdf'
require 'ldp_simple'

rdf =  RDF::Vocabulary.new("http://www.w3.org/1999/02/22-rdf-syntax-ns#")
dcat = RDF::Vocabulary.new("http://www.w3.org/ns/dcat#")
dc = RDF::Vocabulary.new("http://purl.org/dc/elements/1.1/")
dct = RDF::Vocabulary.new("http://purl.org/dc/terms/")
fund = RDF::Vocabulary.new("http://vocab.ox.ac.uk/projectfunding#")
#skos =  RDF::Vocabulary.new("http://www.w3.org/2004/02/skos/core#")


client = LDP::LDPClient.new({
	:endpoint => "http://training.fairdata.solutions/DAV/home/LDP/fair/grazing/285525/",
	:username => "gofair",
	:password => "gofair"})
distribution = client.toplevel_container


  g = RDF::Graph.new() # a graph for the distribution
	dist =  "http://training.fairdata.solutions/DAV/home/LDP/fair/grazing/285525/"
  
  triplify(dist, dc.creator, "http://wilkinsonlab.info", g)
  triplify(dist, dc.title, "A subset of the database of bio-ecological information on non-target arthropod species", g)
  triplify(dist, dct.title, "A subset of the database of bio-ecological information on non-target arthropod species", g)
	triplify(dist, dct.license, "http://data.europa.eu/euodp/kos/licence/EuropeanCommission", g)
	triplify(dist, rdf.type, "http://purl.org/dc/dcmitype/Distribution", g)
		
	triplify(dist, dcat.accessURL, "http://training.fairdata.solutions/sparql", g)
	triplify(dist, dcat.mediaType, "application/sparql-results+xml", g)

  distribution.add_metadata(g.map {|s| [s.subject.to_s, s.predicate.to_s, s.object.to_s]}) 
 




client = LDP::LDPClient.new({
	:endpoint => "http://training.fairdata.solutions/DAV/home/LDP/fair/grazing/",
	:username => "gofair",
	:password => "gofair"})
dataset = client.toplevel_container


  g = RDF::Graph.new() # a graph for the distribution
	dset =  "http://training.fairdata.solutions/DAV/home/LDP/fair/grazing/"
  
  triplify(dset, dc.creator, "http://wilkinsonlab.info", g)
  triplify(dset, dc.title, "A subset of the database of bio-ecological information on non-target arthropod species", g)
  triplify(dset, dct.title, "A subset of the database of bio-ecological information on non-target arthropod species", g)
  triplify(dset, dc.identifier, "10.5281/zenodo.285525", g)
	triplify(dset, fund.hasPrincipalInvestigator,"Riedel, Judith", g)
	triplify(dset, fund.hasPrincipalInvestigator,"Meissle, Michael", g)
	triplify(dset, fund.hasPrincipalInvestigator,"Romeis, Jörg", g)
	triplify(dset, rdf.type, "http://purl.org/dc/dcmitype/Dataset", g)
	
	triplify(dset, dcat.landingPage, "https://ring.ciard.net/update-and-expansion-database-bio-ecological-information-non-target-arthropod-species", g)
	triplify(dset, dcat.landingPage, "https://zenodo.org/record/285525", g)
	triplify(dset, dcat.landingPage, "https://zenodo.org/record/285525", g)

	# TO FILL IN ON THE DAY
#	triplify(dset, dcat.theme, "ONTOLOGY TERM HERE", g)
#	triplify("ONTOLOGY TERM HERE", skos.inScheme, "http://training.fairdata.solutions/DAV/home/LDP/fair/SKOS/pest_scheme.ttl", g)
#	triplify(dset, dcat.theme, "ONTOLOGY TERM HERE", g)
#	triplify("ONTOLOGY TERM HERE", skos.inScheme, "http://training.fairdata.solutions/DAV/home/LDP/fair/SKOS/pest_scheme.ttl", g)
#	triplify(dset, dcat.theme, "ONTOLOGY TERM HERE", g)
#	triplify("ONTOLOGY TERM HERE", skos.inScheme, "http://training.fairdata.solutions/DAV/home/LDP/fair/SKOS/pest_scheme.ttl", g)


  dataset.add_metadata(g.map {|s| [s.subject.to_s, s.predicate.to_s, s.object.to_s]}) 


  #g.each {|s| puts s.subject.to_s + "\t" + s.predicate.to_s + "\t" + s.object.to_s}
