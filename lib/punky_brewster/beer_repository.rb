module PunkyBrewster
  class BeerRepository
    def list
      BeerListRequest.new.beers
    end

    def self.list(*args)
      self.new(*args).list
    end
  end
end
