# Punky Brewster

What's on tap?

## Installation

    gem install punky_brewster

## Usage

    $ punky_brewster
    8  WIRED  HOPWIRED                    $16.00/L  7.3%
    ALL  CHIEFS , NO  INDIANS             $14.00/L  6.0%
    CROUCHER  LOW  RIDER  IPA             $12.00/L  2.7%
    DALES  ESB  (EXTRA  SPECIAL  BITTER)  $14.00/L  5.6%
    ...

    $ punky_brewster --sort price
    CROUCHER LOW RIDER IPA            $12.00/L  2.7%
    TUATARA ITI AMERICAN PALE ALE     $12.50/L  5.8%
    MUSSEL INN CAPTAIN COOKER         $12.50/L  5.7%
    VALKYRIE FRIGG RED PILSENER       $13.50/L  5.0%


    $ punky_brewster --sort abv
    CROUCHER LOW RIDER IPA            $12.00/L  2.7%
    RENAISSANCE PARADOX PILSENER      $14.00/L  4.0%
    GARAGE PROJECT HAPI DAZE          $14.00/L  4.2%
    GOLDEN ALE FRESH HOP              $16.00/L  4.5%
    INVERCARGILL PITCHBLACK STOUT     $13.50/L  4.5%

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/Aupajo/punky_brewster/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
