require 'rubygems'
require 'nokogiri'

class ITunesParser
  def initialize(filename)
    @filename = filename
    @result = nil
  end
  
  def parse
    library_file = File.open(@filename, 'r')
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
    @result = songs
  end
  
  
  def result
    @result
  end
end

file_name = "/Users/roeschinc/Music/iTunes/iTunes Music Library.xml"

itunes = ITunesParser.new(file_name)

songs = itunes.parse

song_list = songs.map { |song| song["Name"] }

puts song_list