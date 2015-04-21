require 'json'
require 'punky_brewster'

module PunkyBrewster
  class Server
    def self.call(env)
      headers = { 'Content-Type' => 'application/json' }

      begin
        beers = BeerListRequest.new.beers
        beers_properties = beers.map(&:to_h)
        body = JSON.generate(beers_properties)
        status = 200
      rescue => error
        body = JSON.generate(error: "#{error.class}: #{error}")
        status = 500
      end

      [status, headers, [body]]
    end
  end
end
