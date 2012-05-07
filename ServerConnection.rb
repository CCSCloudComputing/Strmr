# The way to communicate with the server, using HTTP
class ServerConnection
  def initialize(host)
    @host = host
  end
  
  attr_reader :host
end
