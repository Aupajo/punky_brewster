require "thor"
require "punky_brewster"

module PunkyBrewster
  class CLI < Thor
    map "--version" => :version

    desc "version", "Show version"
    def version
      say "Punky Brewster version #{VERSION}"
    end

    desc "list", "Show current beer list"
    method_option :sort, default: "name", enum: %w( name price abv )
    def list
      beers = BeerListRequest.new.beers
      sorted = beers.sort_by { |beer| beer.send(options[:sort]) }

      rows = sorted.map do |beer|
        [beer.name, "$%0.2f/L" % beer.price, "%0.1f%" % beer.abv]
      end

      print_table rows
    end

    default_task :list
  end
end
