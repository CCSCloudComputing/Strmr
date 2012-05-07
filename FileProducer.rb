require './ServerConnection'
require 'net/http'

# Utilizes the ServerConnection, to transparently stream a file to the server
class FileProducer
  def initialize(file, connection)
    @file = file
    @connection = connection
  end
  
  def produce
    File.open(@file, 'r') { |f|
      http.post(@connection)
    } 
  end
end