# Punky Brewster

What's on tap?

## Installation

    gem install punky_brewster

## Command line tool

List beers:

    $ punky_brewster
    8  WIRED  HOPWIRED                    $16.00/L  7.3%
    ALL  CHIEFS , NO  INDIANS             $14.00/L  6.0%
    CROUCHER  LOW  RIDER  IPA             $12.00/L  2.7%
    DALES  ESB  (EXTRA  SPECIAL  BITTER)  $14.00/L  5.6%
    ...

Sort beers (can be sorted by `price`, `abv`, or `abv_per_dollar`):

    $ punky_brewster --sort price
    CROUCHER LOW RIDER IPA            $12.00/L  2.7%
    TUATARA ITI AMERICAN PALE ALE     $12.50/L  5.8%
    MUSSEL INN CAPTAIN COOKER         $12.50/L  5.7%
    VALKYRIE FRIGG RED PILSENER       $13.50/L  5.0%
    ...

List beers sorted by most ABV per dollar:

    $ punky_brewster --holla-for-dollar
    MIKE'S VANILLA COFFEE PORTER      $16.00/L  8.0%  0.50%/$
    RAINDOGS OXYMORON BLACK IPA       $14.50/L  7.0%  0.48%/$
    GOLDEN EAGLE BIG YANK             $16.00/L  7.5%  0.47%/$
    MUSSEL INN CAPTAIN COOKER         $12.50/L  5.7%  0.46%/$
    ...


## Ruby Library

```ruby
require 'punky_brewster'
BeerListRequest.new.beers
```

## JSON API Server

A simple `config.ru`:

```ruby
require 'punky_brewster/server'
run PunkyBrewster::Server
```

Mount alongside other Rack apps (Rails, Sinatra, etc.):

```ruby
require 'punky_brewster/server'
run Rack::URLMap.new("/punky_brewster/beers.json" => PunkyBrewster::Server)
```

Need JSONP? Use the `rack-contrib` gem:

```ruby
require 'rack/contrib/json'
require 'punky_brewster/server'
use Rack::JSONP
run PunkyBrewster::Server
```

Response:

```json
[
  {
    "name": "EPIC PALE ALE",
    "price": 14.0,
    "abv": 5.4,
    "image_url": "http://www.punkybrewster.co.nz/uploads/..."
  },
  ...
]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/Aupajo/punky_brewster/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
