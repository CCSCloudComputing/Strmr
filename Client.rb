require 'rubygems'
require 'nokogiri'

file_name = "/Users/roeschinc/Music/iTunes/iTunes Music Library.xml"

library_file = File.open(file_name, 'r')

library_xml = Nokogiri::XML(library_file.read)

# Fragile Parsing Method Currently works well for our purposes
# Needs some clean up also
songs = library_xml.css("dict > dict > dict").map do |dict|
  nodes = dict.css("*").map { |i| i.content.to_s } 
  song = {}; i = 0;
  # Check for now to make sure each key is paired with a value
  throw "Not Even." unless nodes.length % 2 == 0
  while i < nodes.length
    song[nodes[i]] = nodes[i+1]
    i += 2
  end
  song
end

class iTunesParser
  
end
