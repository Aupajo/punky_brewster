require 'minitest_helper'

class TestBeerListResponse < Minitest::Test
  include PunkyBrewster

  def response
    VCR.use_cassette("whats-pouring") do
      BeerListRequest.new.response
    end
  end

  def test_returns_all_beers
    assert_equal 21, response.beers.length
  end

  def test_beer_properties
    beer = response.beers.first
    assert_equal 'EPIC PALE ALE', beer.name
    assert_equal 14.00, beer.price
    assert_equal 5.4, beer.abv
  end
end
