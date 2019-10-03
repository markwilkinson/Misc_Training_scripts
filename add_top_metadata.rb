require './utils.rb'
require 'rdf'
require 'ldp_simple'

rdf =  RDF::Vocabulary.new("http://www.w3.org/1999/02/22-rdf-syntax-ns#")
#rdfs = RDF::Vocabulary.new("http://www.w3.org/2000/01/rdf-schema#")

#ldp = RDF::Vocabulary.new("http://www.w3.org/ns/ldp#")
dcat = RDF::Vocabulary.new("http://www.w3.org/ns/dcat#")
dc = RDF::Vocabulary.new("http://purl.org/dc/elements/1.1/")
dct = RDF::Vocabulary.new("http://purl.org/dc/terms/")
fund = RDF::Vocabulary.new("http://vocab.ox.ac.uk/projectfunding#")

me =  "http://training.fairdata.solutions/DAV/home/LDP/fair/grazing/"

client = LDP::LDPClient.new({
	:endpoint => "http://training.fairdata.solutions/DAV/home/LDP/fair/grazing/",
	:username => "gofair",
	:password => "gofair"})
top = client.toplevel_container


  g = RDF::Graph.new()
  
  triplify(me, dc.creator, "http://wilkinsonlab.info", g)
	triplify(me, dct.license, "http://data.europa.eu/euodp/kos/licence/EuropeanCommission", g)
  triplify(me, dc.title, "A subset of the database of bio-ecological information on non-target arthropod species", g)
  triplify(me, dc.identifier, "10.5281/zenodo.285525", g)
	triplify(me, fund.hasPrincipalInvestigator,"Riedel, Judith", g)
	triplify(me, fund.hasPrincipalInvestigator,"Meissle, Michael", g)
	triplify(me, fund.hasPrincipalInvestigator,"Romeis, Jörg", g)
	triplify(me, rdf.type, "http://purl.org/dc/dcmitype/Dataset", g)
	triplify(me, dcat.landingPage, "https://ring.ciard.net/update-and-expansion-database-bio-ecological-information-non-target-arthropod-species", g)
	triplify(me, dcat.landingPage, "https://zenodo.org/record/285525", g)

	triplify(me, dcat.theme, "http://training.fairdata.solutions/DAV/home/LDP/fair/SKOS/pest_scheme.ttl", g)

  top.add_metadata(g.map {|s| [s.subject.to_s, s.predicate.to_s, s.object.to_s]}) 
 
  g.each {|s| puts s.subject.to_s + "\t" + s.predicate.to_s + "\t" + s.object.to_s}
