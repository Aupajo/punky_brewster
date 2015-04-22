module PunkyBrewster
  class Beer < Struct.new(:name, :price, :abv, :image_url)
    def abv_per_dollar
      (abv.to_f / price).round(2)
    end
  end
end
