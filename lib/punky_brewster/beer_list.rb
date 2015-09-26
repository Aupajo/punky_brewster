require 'json'

module PunkyBrewster
  class BeerList < Array
    def serialized_properties
      map(&:to_h)
    end

    def to_json
      JSON.generate(serialized_properties)
    end
  end
end
