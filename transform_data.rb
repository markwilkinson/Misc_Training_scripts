require './utils.rb'
require 'rdf'
require 'ldp_simple'

rdf =  RDF::Vocabulary.new("http://www.w3.org/1999/02/22-rdf-syntax-ns#")
rdfs = RDF::Vocabulary.new("http://www.w3.org/2000/01/rdf-schema#")

#ldp = RDF::Vocabulary.new("http://www.w3.org/ns/ldp#")

sio = RDF::Vocabulary.new("http://semanticscience.org/resource/")
uo =  RDF::Vocabulary.new("http://purl.obolibrary.org/obo/uo.owl#")
efo = RDF::Vocabulary.new("http://www.ebi.ac.uk/efo/efo.owl#")
geo = RDF::Vocabulary.new("http://www.w3.org/2003/01/geo/wgs84_pos#")

lsid = RDF::Vocabulary.new("http://www.eu-nomen.eu/portal/taxon.php?GUID=")
food = RDF::Vocabulary.new("http://data.food.gov.uk/codes/foodtype/hierarchy/facet/source/_")
wiki = RDF::Vocabulary.new("https://en.wikipedia.org/wiki/ISO_3166-2:")


my =   RDF::Vocabulary.new("http://training.fairdata.solutions/DAV/home/LDP/fair/grazing/")
client = LDP::LDPClient.new({
	:endpoint => "http://training.fairdata.solutions/DAV/home/LDP/fair/grazing/",
	:username => "gofair",
	:password => "gofair"})
top = client.toplevel_container

#abort


obs = File.open("SpeciesAbundancePub2015.tsv")
obs.readline # discard header
spe = File.open("SpeciesInfoPub2015.tsv")
spe.readline # discard header

count = 0
obs.each do |line|
  (id, cropC, cropN, species, countryC, countryN, year, duration, long, lat, comments) = line.split("\t")
  count += 1
  break if count > 500
  g = RDF::Graph.new()

  observation = "obs_#{id}"    # obs_12345657
  species = "species_#{species}"  # species_3456789
  $stderr.puts "#{count} #{observation} #{species}"
  triplify(my["#{observation}#obs"], rdf.type, sio.measuring, g)
  triplify(my["#{observation}#obs"], rdfs.label, comments, g)
  triplify(my["#{observation}#obs"], sio["is-located-in"], wiki[countryC], g)
  triplify(my["#{observation}#obs"], sio["measured-at"], my["#{observation}#time"], g)
  triplify(my["#{observation}#obs"], sio["has-participant"], my["#{observation}#infection"], g)
  
  triplify(my["#{observation}#location"], sio["is-location-of"], my["#{observation}#obs"], g)
  triplify(my["#{observation}#location"], rdf.type, geo.Point, g)
  triplify(my["#{observation}#location"], geo.lat, lat, g)
  triplify(my["#{observation}#location"], geo.long, long, g)

  triplify(wiki[countryC], rdf.type, sio.country, g)
  triplify(wiki[countryC], rdfs.label, countryN, g)

  triplify(my["#{observation}#time"], rdf.type, sio["time-interval"], g)
  triplify(my["#{observation}#time"], sio["has-value"], duration, g)
  triplify(my["#{observation}#time"], sio["has-unit"], uo["UO_0000036"], g)
  triplify(uo["UO_0000036"], rdfs.label, "Year", g)
  
  triplify(my["#{observation}#infection"], rdf.type, efo["EFO_0001067"], g)
  triplify(efo["EFO_0001067"], rdfs.label, "Parasitic Infection", g)
  triplify(my["#{observation}#infection"], sio["has-participant"], my["#{species}#species"], g)
  triplify(my["#{observation}#infection"], sio["has-participant"], food[cropC], g)
  
  triplify(food[cropC], rdfs.label, cropN, g)
  triplify(food[cropC], rdf.type, sio.host, g)

  triplify(my["#{species}#species"], rdf.type, sio.pathogen, g)

  newresource = top.add_rdf_resource(:slug => observation)
  newresource.add_metadata(g.map {|s| [s.subject.to_s, s.predicate.to_s, s.object.to_s]}) 
 
  #g.each {|s| puts s.subject.to_s + "\t" + s.predicate.to_s + "\t" + s.object.to_s}
  #break
end

count = 0
spe.each do |line|
  (species, gbif, name) = line.split("\t")
  next if gbif.empty? or name.empty? or species.empty?
  species = "species_#{species}"  # species_3456789
  count += 1
  break if count > 500
  $stderr.puts "#{count} #{species} SPECIES TABLE"

  g = RDF::Graph.new()
  triplify(my["#{species}#species"], rdf.type, sio.pathogen, g)
  triplify(my["#{species}#species"], rdfs.label, name, g)
  triplify(my["#{species}#species"], sio["has-identifier"], lsid[gbif], g)
  triplify(my["#{species}#species"], rdf.type, sio.pathogen, g)
  triplify(lsid["#{gbif}"], rdfs.label, name, g)
  triplify(lsid["#{gbif}"], rdf.type, sio.identifier, g)

  newresource = top.add_rdf_resource(:slug => species)
  newresource.add_metadata(g.map {|s| [s.subject.to_s, s.predicate.to_s, s.object.to_s]}) 
 
  #g.each {|s| puts s.subject.to_s + "\t" + s.predicate.to_s + "\t" + s.object.to_s}
  #break
end





