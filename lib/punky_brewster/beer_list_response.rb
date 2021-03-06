require "nokogiri"

module PunkyBrewster
  class BeerListResponse
    IMAGE_URL_BASE = 'http://www.punkybrewster.co.nz'

    def initialize(raw_response)
      @raw_response = raw_response
    end

    def beers
      @beers ||= begin
        content = document.at_css('#content')
        list = []

        content.traverse do |node|
          if node.name == 'h2'
            list << Beer.new
            # Includes non-breaking spaces
            list.last.name = node.text.upcase.gsub(/[\s\u00A0]+/, ' ')
          elsif node.name == 'img'
            list.last.image_url = IMAGE_URL_BASE + node[:src]
          elsif price = node.text.scan(/^\$(\d+\.\d+)\/L$/).flatten.first
            list.last.price = price.to_f
          elsif abv = node.text.scan(/(\d+\.\d+)\s*%/).flatten.first
            list.last.abv = abv.to_f
          end
        end

        BeerList.new(list.select(&:valid?))
      end
    end

    private

    def document
      @document ||= Nokogiri::HTML(@raw_response.body)
    end
  end
end
