require 'json'
require 'punky_brewster'

module PunkyBrewster
  class Server

    def call(env)
      headers = { 'Content-Type' => 'application/json' }

      begin
        body = BeerRepository.list.to_json
        status = 200
      rescue => error
        body = JSON.generate(error: "#{error.class}: #{error}")
        status = 500
      end

      [status, headers, [body]]
    end

    def self.call(env)
      self.new.call(env)
    end

  end
end
