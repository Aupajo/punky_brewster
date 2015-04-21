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
      beers = BeerListRequest.new.beers

      rows = beers.sort_by(&:name).map do |beer|
        [beer.name, "$%0.2f/L" % beer.price, "%0.1f%" % beer.abv]
      end

      print_table rows
    end

    default_task :list
  end
end
