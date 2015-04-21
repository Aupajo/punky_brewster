module PunkyBrewster
  class BeerListResponse
    def initialize(raw_response)
      @raw_response = raw_response
    end

    def beers
      @beers ||= begin
        content = document.at_css('#content')
        divide = content.at_css('.styled-hr')
        past_divide = false
        beer_list = []

        content.traverse do |node|
          past_divide = true if node == divide
          next unless past_divide

          if node.name == 'h2'
            beer_list << Beer.new
            # Includes non-breaking spaces
            beer_list.last.name = node.text.upcase.gsub(/[\s\u00A0]+/, ' ')
          elsif price = node.text.scan(/^\$(\d+\.\d+)\/L$/).flatten.first
            beer_list.last.price = price.to_f
          elsif abv = node.text.scan(/(\d+\.\d+)\s*%/).flatten.first
            beer_list.last.abv = abv.to_f
          end
        end

        beer_list
      end
    end

    private

    def document
      @document ||= Nokogiri::HTML(@raw_response.body)
    end
  end
end
