require 'minitest_helper'

class TestCLI < Minitest::Test
  def test_abv_per_dollar
    beer = PunkyBrewster::Beer.new
    beer.price = 12.50
    beer.abv = 5.4
    assert_equal 0.43, beer.abv_per_dollar
  end

  def test_valid
    beer = PunkyBrewster::Beer.new
    refute beer.valid?
    beer.name = "Renaissance Sencha Saison"
    beer.price = 12.50
    beer.abv = 5.4
    beer.image_url = 'url'
    assert beer.valid?
  end
end
