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
    method_option :sort, default: "name", enum: %w( name price abv abv_per_dollar )
    method_option :cheapskate, type: :boolean, default: false
    method_option :holla_for_dollar, type: :boolean, default: false
    def list
      show_abv_per_dollar = options[:holla_for_dollar] || options[:cheapskate]

      beers = BeerRepository.list

      if options[:holla_for_dollar]
        sorted = beers.sort { |a, b| b.abv_per_dollar <=> a.abv_per_dollar }
      else
        sorted = beers.sort_by { |beer| beer.send(options[:sort]) }
      end

      rows = sorted.map do |beer|
        row = [beer.name, "$%0.2f/L" % beer.price, "%0.1f%" % beer.abv]
        row << ("%0.2f%%/$" % beer.abv_per_dollar) if show_abv_per_dollar
        row
      end

      print_table rows
    end

    default_task :list
  end
end
