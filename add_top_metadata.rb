require './utils.rb'
require 'rdf'
require 'ldp_simple'

rdf =  RDF::Vocabulary.new("http://www.w3.org/1999/02/22-rdf-syntax-ns#")
dcat = RDF::Vocabulary.new("http://www.w3.org/ns/dcat#")
dc = RDF::Vocabulary.new("http://purl.org/dc/elements/1.1/")
dct = RDF::Vocabulary.new("http://purl.org/dc/terms/")
fund = RDF::Vocabulary.new("http://vocab.ox.ac.uk/projectfunding#")
skos =  RDF::Vocabulary.new("http://www.w3.org/2004/02/skos/core#")


dctype =  RDF::Vocabulary.new("http://purl.org/dc/dcmitype/")
foaf =  RDF::Vocabulary.new("http://xmlns.com/foaf/0.1/")
locn	 =  RDF::Vocabulary.new("http://www.w3.org/ns/locn#")
odrl	 =  RDF::Vocabulary.new("http://www.w3.org/ns/odrl/2/")
owl	 =  RDF::Vocabulary.new("http://www.w3.org/2002/07/owl#")
prov	 =  RDF::Vocabulary.new("http://www.w3.org/ns/prov#")

rdfs	 =  RDF::Vocabulary.new("http://www.w3.org/2000/01/rdf-schema#")
time	 =  RDF::Vocabulary.new("http://www.w3.org/2006/time#")
vcard	 =  RDF::Vocabulary.new("http://www.w3.org/2006/vcard/ns#")
xsd	 =  RDF::Vocabulary.new("http://www.w3.org/2001/XMLSchema#")



client = LDP::LDPClient.new({
#	:endpoint => "http://ldp.cbgp.upm.es:8890/DAV/home/LDP/Training/grazing/285525/",
#	:endpoint => "http://ejprd.fair-dtls.surf-hosted.nl:8890/DAV/home/LDP/EJP/",
	:endpoint => "http://ejprd.fair-dtls.surf-hosted.nl:8890/DAV/home/LDP/EJP/erdri_catalog/",
	:username => "ldp",
	:password => "ldp"})
distribution = client.toplevel_container
puts distribution

  g = RDF::Graph.new() # a graph for the distribution
  
  dist =  "http://ejprd.fair-dtls.surf-hosted.nl:8890/DAV/home/LDP/EJP/erdri_catalog/"
	
  triplify(dist, dcat.themeTaxonomy, "http://ejprd.fair-dtls.surf-hosted.nl:8890/DAV/home/LDP/EJP/erdri_skos.rdf", g)
  triples = g.map {|s| [s.subject.to_s, s.predicate.to_s, s.object.to_s]}
  distribution.add_metadata(triples) 
  abort
  
#	dist =  "http://ejprd.fair-dtls.surf-hosted.nl:8890/DAV/home/LDP/EJP/"
#	
#	[
#	 'http://ejprd.fair-dtls.surf-hosted.nl:8890/DAV/home/LDP/EJP/EJP_HACK/' ,
#	 'http://ejprd.fair-dtls.surf-hosted.nl:8890/DAV/home/LDP/EJP/erdri_catalog/',
#	 'http://ejprd.fair-dtls.surf-hosted.nl:8890/DAV/home/LDP/EJP/orphanet_catalog/',
#	 'http://ejprd.fair-dtls.surf-hosted.nl:8890/DAV/home/LDP/EJP/rd-sample_catalog/' ,
#	 'http://ejprd.fair-dtls.surf-hosted.nl:8890/DAV/home/LDP/EJP/rdc-finder_catalog/' ,
#	 'http://ejprd.fair-dtls.surf-hosted.nl:8890/DAV/home/LDP/EJP/bbmri-eric/',
#	 'http://ejprd.fair-dtls.surf-hosted.nl:8890/DAV/home/LDP/EJP/rd-connect/'].each do |cat|
#			triplify(dist, dcat.catalog, cat, g)
#		end
#  
#  triplify(dist, foaf.homepage, "https://github.com/ejp-rd-vp/resource-metadata-schema", g)
#  
#  triplify(dist, dct.language, "http://id.loc.gov/vocabulary/iso639-1/en", g)
#  triplify("http://id.loc.gov/vocabulary/iso639-1/en", rdf.type, dct.LinguisticSystem, g)
#  triplify(dist, dcat.contactPoint, dist+"#contact", g)
#  triplify(dist+"#contact", vcard.fn, "Mark Wilkinson", g)
#  triplify(dist+"#contact", vcard.nickname, "MarkMoby", g)
#  triplify(dist+"#contact", vcard.hasEmail, "mailto:markw@illuminae.com", g)
#  
#  triplify(dist, dct.creator, "https://github.com/simonjupp", g)
#  triplify(dist, dct.creator, "https://github.com/S2Ola", g)
#  triplify(dist, dct.creator, "https://github.com/rajaram5", g)
#  triplify(dist, dct.creator, "https://github.com/ronaldcornet", g)
#  triplify(dist, dct.creator, "https://github.com/markwilkinson", g)
#  triplify("https://github.com/simonjupp", rdf.type, foaf.Person , g)
#  triplify("https://github.com/S2Ola", rdf.type, foaf.Person , g)
#  triplify("https://github.com/rajaram5", rdf.type, foaf.Person , g)
#  triplify("https://github.com/ronaldcornet", rdf.type, foaf.Person , g)
#  triplify("https://github.com/markwilkinson", rdf.type, foaf.Person , g)
#  triplify(dist, dct.identifier, "http://ejprd.fair-dtls.surf-hosted.nl:8890/DAV/home/LDP/EJP/", g)
#  triplify(dist, dct.publisher, "http://wilkinsonlab.info", g)
#  triplify(dist, dct.title, "Top-level Catalogue for the EJP-RD hackathon", g)
#  triplify(dist, dct.description, "An LDP Container to contain all of the (mock) catalogues for the EJP-RD project Hackathon", g)
#	triplify(dist, dct.license, "https://creativecommons.org/share-your-work/public-domain/cc0/", g)
#	triplify(dist, rdf.type, dcat.Catalog, g)
#  triplify(dist, dcat.landingPage, "https://www.ejprarediseases.org/", g)		
#
#
#  triples = g.map {|s| [s.subject.to_s, s.predicate.to_s, s.object.to_s]}
#  puts triples
  
  #distribution.add_metadata() 
 
  #g.each {|s| puts s.subject.to_s + "\t" + s.predicate.to_s + "\t" + s.object.to_s}




#client = LDP::LDPClient.new({
#	:endpoint => "http://ldp.cbgp.upm.es:8890/DAV/home/LDP/Training/grazing/",
#	:username => "gofair",
#	:password => "gofair"})
#dataset = client.toplevel_container
#
#
#  g = RDF::Graph.new() # a graph for the distribution
#	dset =  "http://training.fairdata.solutions/DAV/home/LDP/fair/grazing/"
#  
#  triplify(dset, dc.creator, "http://wilkinsonlab.info", g)
#  triplify(dset, dc.title, "A subset of the database of bio-ecological information on non-target arthropod species", g)
#  triplify(dset, dct.title, "A subset of the database of bio-ecological information on non-target arthropod species", g)
#  triplify(dset, dc.identifier, "10.5281/zenodo.285525", g)
#	triplify(dset, fund.hasPrincipalInvestigator,"Riedel, Judith", g)
#	triplify(dset, fund.hasPrincipalInvestigator,"Meissle, Michael", g)
#	triplify(dset, fund.hasPrincipalInvestigator,"Romeis, Jörg", g)
#	triplify(dset, rdf.type, dcat.Dataset, g)
#	
#	triplify(dset, dcat.landingPage, "https://ring.ciard.net/update-and-expansion-database-bio-ecological-information-non-target-arthropod-species", g)
#	triplify(dset, dcat.landingPage, "https://zenodo.org/record/285525", g)
#	triplify(dset, dcat.landingPage, "http://training.fairdata.solutions/DAV/home/LDP/fair/grazing/", g)
#	
#	triplify(dset, dcat.distribution, dist, g)  #  LOOK!!!!

	# TO FILL IN ON THE DAY
#	triplify(dset, dcat.theme, "ONTOLOGY TERM HERE", g)
#	triplify("ONTOLOGY TERM HERE", skos.inScheme, "http://training.fairdata.solutions/DAV/home/LDP/fair/grazing/pest_skos.rdf", g)
#	triplify(dset, dcat.theme, "ONTOLOGY TERM HERE", g)
#	triplify("ONTOLOGY TERM HERE", skos.inScheme, "http://training.fairdata.solutions/DAV/home/LDP/fair/grazing/pest_skos.rdf", g)
#	triplify(dset, dcat.theme, "ONTOLOGY TERM HERE", g)
#	triplify("ONTOLOGY TERM HERE", skos.inScheme, "http://training.fairdata.solutions/DAV/home/LDP/fair/grazing/pest_skos.rdf", g)


#  dataset.add_metadata(g.map {|s| [s.subject.to_s, s.predicate.to_s, s.object.to_s]}) 


  #g.each {|s| puts s.subject.to_s + "\t" + s.predicate.to_s + "\t" + s.object.to_s}
