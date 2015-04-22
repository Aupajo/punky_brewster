require "punky_brewster/version"
require "punky_brewster/beer_list_request"
require "punky_brewster/beer_list_response"

module PunkyBrewster
  Beer = Struct.new(:name, :price, :abv, :image_url)
end
