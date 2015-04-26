module PunkyBrewster
  class Beer < Struct.new(:name, :price, :abv, :image_url)
    def abv_per_dollar
      (abv.to_f / price).round(2)
    end

    # Returns true if all expected values have been set.
    def valid?
      values.compact.length == members.length
    end
  end
end
