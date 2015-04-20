require "thor"
require "punky_brewster"
require "nokogiri"
require "open-uri"

module PunkyBrewster
  class CLI < Thor
    map "--version" => :version

    desc "version", "Show version"
    def version
      say "Punky Brewster version #{VERSION}"
    end

    desc "list", "Show current beer list"
    def list
      response = open("http://www.punkybrewster.co.nz")
      document = Nokogiri::HTML(response)
      content = document.at_css('#content')
      divide = content.at_css('.styled-hr')
      past_divide = false
      beers = []

      content.traverse do |node|
        past_divide = true if node == divide
        next unless past_divide

        if node.name == 'h2'
          beers << Beer.new
          beers.last.name = node.text.upcase.gsub(/\s+/, ' ')
        elsif price = node.text.scan(/^\$(\d+\.\d+)\/L$/).flatten.first
          beers.last.price = price.to_f
        elsif abv = node.text.scan(/(\d+\.\d+)\s*%/).flatten.first
          beers.last.abv = abv.to_f
        end
      end

      rows = beers.sort_by(&:name).map do |beer|
        [beer.name, "$%0.2f/L" % beer.price, "%0.1f%" % beer.abv]
      end

      print_table rows
    end

    default_task :list
  end
end
