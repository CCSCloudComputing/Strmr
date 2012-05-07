require 'rubygems'
require 'nokogiri'

class Array 
  def dict_zip(xs)
    dict = {}
    n = length > xs.length ? length : length.xs
    (0..n).each do |i|
      dict[self[i]] = xs[i]
    end
    dict
  end
end

file_name = "/Users/roeschinc/Music/iTunes/iTunes Music Library.xml"

library_file = File.open(file_name, 'r')

library = Nokogiri::XML(library_file.read)

songs = library.xpath("//dict").map do |dict|
  keys = dict.xpath("//key").map { |i| i.content }
  values = dict.xpath("//string").map { |i| i.content }
  keys.dict_zip(values)
end

puts songs[0]
