require "net/http"

module PunkyBrewster
  class BeerListRequest
    URL = "http://www.punkybrewster.co.nz"

    def response
      raw_response = Net::HTTP.get_response(URI(URL))
      BeerListResponse.new(raw_response)
    end

    def beers
      response.beers
    end
  end
end
